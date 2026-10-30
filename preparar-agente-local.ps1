$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'
Set-Location $PSScriptRoot
$toolsRoot=Join-Path $PSScriptRoot '.cp6-tools'
$agentRoot=Join-Path $PSScriptRoot '.cp6-agent'
New-Item -ItemType Directory -Path $toolsRoot,$agentRoot -Force | Out-Null
if(Test-Path 'agente-local.json'){
 $existing=Get-Content agente-local.json | ConvertFrom-Json
 if($existing.pid){
  $process=Get-Process -Id $existing.pid -ErrorAction SilentlyContinue
  if($process -and $process.Path -eq (Join-Path $agentRoot 'bin\Agent.Listener.exe')){Write-Output "Agente ja esta iniciado: PID $($existing.pid)";exit 0}
 }
}
function DownloadZip([string]$Url,[string]$Name){
 $archive=Join-Path $toolsRoot "$Name.zip"
 $destination=Join-Path $toolsRoot $Name
 if(-not (Test-Path $destination)){
  Write-Host "Baixando $Name"
  Invoke-WebRequest $Url -OutFile $archive -UseBasicParsing
  Expand-Archive -LiteralPath $archive -DestinationPath $destination -Force
 }
 return $destination
}
$jdk17Root=DownloadZip 'https://aka.ms/download-jdk/microsoft-jdk-17-windows-x64.zip' 'jdk17'
$jdk11Root=DownloadZip 'https://aka.ms/download-jdk/microsoft-jdk-11-windows-x64.zip' 'jdk11'
$mavenRoot=DownloadZip 'https://archive.apache.org/dist/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip' 'maven'
$env:JAVA_HOME_17_X64=(Get-ChildItem $jdk17Root -Directory | Select-Object -First 1).FullName
$env:JAVA_HOME_11_X64=(Get-ChildItem $jdk11Root -Directory | Select-Object -First 1).FullName
$env:JAVA_HOME=$env:JAVA_HOME_17_X64
$env:MAVEN_HOME=(Get-ChildItem $mavenRoot -Directory | Select-Object -First 1).FullName
$env:PATH="$env:JAVA_HOME\bin;$env:MAVEN_HOME\bin;C:\Program Files\Git\bin;C:\Program Files\Git\usr\bin;$env:PATH"
$access=az account get-access-token --resource 499b84ac-1321-427f-aa17-267ca6975798 -o json | ConvertFrom-Json
if($LASTEXITCODE -ne 0){throw 'Falha ao autenticar Azure DevOps'}
$headers=@{Authorization="Bearer $($access.accessToken)"}
$org='https://dev.azure.com/Azure-DevOps-561439'
$project='c9d9c297-b65b-487b-adab-92cd6b80a815'
$pools=Invoke-RestMethod "$org/_apis/distributedtask/pools?api-version=7.1" -Headers $headers
$pool=$pools.value | Where-Object name -eq 'CP6-Local'
if(-not $pool){$pool=Invoke-RestMethod "$org/_apis/distributedtask/pools?api-version=7.1" -Headers $headers -Method POST -ContentType 'application/json' -Body '{"name":"CP6-Local","isHosted":false,"autoProvision":false,"autoUpdate":true}'}
$queues=Invoke-RestMethod "$org/$project/_apis/distributedtask/queues?api-version=7.1" -Headers $headers
$queue=$queues.value | Where-Object name -eq 'CP6-Local'
if(-not $queue){$queue=Invoke-RestMethod "$org/$project/_apis/distributedtask/queues?api-version=7.1" -Headers $headers -Method POST -ContentType 'application/json' -Body (@{name='CP6-Local';pool=@{id=$pool.id}} | ConvertTo-Json)}
$permission=Invoke-RestMethod "$org/$project/_apis/pipelines/pipelinePermissions/queue/$($queue.id)?api-version=7.1-preview.1" -Headers $headers -Method PATCH -ContentType 'application/json' -Body '{"pipelines":[{"id":1,"authorized":true},{"id":2,"authorized":true},{"id":3,"authorized":true}]}'
@{pool=$pool.id;queue=$queue.id} | ConvertTo-Json | Set-Content agente-local.json -Encoding UTF8
if(-not (Test-Path (Join-Path $agentRoot 'config.cmd'))){
 try{
  $package=Invoke-RestMethod "$org/_apis/distributedtask/packages/agent?platform=win-x64&top=1&api-version=7.1-preview.1" -Headers $headers
  $download=$package.value | Select-Object -First 1
 }catch{
  $release=Invoke-RestMethod 'https://api.github.com/repos/microsoft/azure-pipelines-agent/releases/latest' -Headers @{'User-Agent'='CP6-Setup'}
  if($release -is [string]){$release=$release | ConvertFrom-Json}
  $version=$release.tag_name.TrimStart('v')
  $download=@{version=$version;downloadUrl="https://download.agent.dev.azure.com/agent/$version/vsts-agent-win-x64-$version.zip"}
 }
 if(-not $download.downloadUrl){throw 'Pacote oficial do agente indisponivel'}
 $archive=Join-Path $toolsRoot 'agent.zip'
 Write-Output "Baixando agente $($download.version)"
 Invoke-WebRequest $download.downloadUrl -OutFile $archive -UseBasicParsing
 Expand-Archive -LiteralPath $archive -DestinationPath $agentRoot -Force
}
Push-Location $agentRoot
try{
 if(-not (Test-Path '.agent')){
  $env:VSTS_AGENT_INPUT_AUTH='pat'
  $env:VSTS_AGENT_INPUT_TOKEN=$access.accessToken
  & .\config.cmd --unattended --url $org --pool CP6-Local --agent CP6-RM561439 --work _work --acceptTeeEula
  if($LASTEXITCODE -ne 0){throw 'Falha ao registrar agente; nenhuma pipeline foi alterada para usa-lo.'}
  Remove-Item Env:\VSTS_AGENT_INPUT_TOKEN
  Remove-Item Env:\VSTS_AGENT_INPUT_AUTH
 }
 $listener=Join-Path $agentRoot 'bin\Agent.Listener.exe'
 $proc=Start-Process -FilePath $listener -ArgumentList 'run' -WorkingDirectory $agentRoot -WindowStyle Hidden -PassThru -RedirectStandardOutput (Join-Path $agentRoot 'listener.log') -RedirectStandardError (Join-Path $agentRoot 'listener-errors.log')
 @{pid=$proc.Id;pool=$pool.id;queue=$queue.id;agentFolder=$agentRoot} | ConvertTo-Json | Set-Content (Join-Path $PSScriptRoot 'agente-local.json') -Encoding UTF8
 Write-Output "Agente temporario iniciado: PID $($proc.Id)"
}finally{Pop-Location}
