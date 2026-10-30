$ErrorActionPreference='Stop'
$info=Get-Content (Join-Path $PSScriptRoot 'agente-local.json') | ConvertFrom-Json
$expected=Join-Path $PSScriptRoot '.cp6-agent\bin\Agent.Listener.exe'
$process=Get-Process -Id $info.pid -ErrorAction SilentlyContinue
if($process){
 if($process.Path -ne $expected){throw 'O PID agora pertence a outro programa; nenhuma acao executada.'}
 Stop-Process -Id $info.pid
 Write-Output 'Agente temporario encerrado. Para novo CI/CD, execute preparar-agente-local.ps1.'
}else{Write-Output 'Agente ja estava encerrado.'}
