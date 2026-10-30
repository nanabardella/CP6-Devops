# Narração para o vídeo CP6

O vídeo está sem áudio. Grave sua voz seguindo os trechos abaixo. Os tempos indicam o início e o fim de cada cena; há alguns segundos de navegação antes de a tela estabilizar. Você pode pausar ou ajustar os trechos no editor.

## 00:00–00:14 — Apresentação do projeto

Sou Giovanna, RM561439. Nesta atividade vou demonstrar três fluxos completos de integração e entrega contínuas no projeto CP6 Azure DevOps.

## 00:14–00:35 — Roshambo: alteração e commit

No Roshambo, a alteração do index.jsp mudou o texto da versão um para a versão dois. O commit registra exatamente essa mudança na branch main.

## 00:35–00:51 — Roshambo: configuração clássica

A integração contínua usa o editor clássico. O job executa Maven, testes, cópia do WAR e publicação do artefato. O agente utilizado pertence ao pool CP6 Local.

## 00:51–01:10 — Roshambo: execução automática

A execução doze foi disparada pelo commit. O motivo Individual CI comprova o acionamento automático. O mesmo hash aparece na versão do repositório usada pela build.

## 01:10–01:26 — Roshambo: testes aprovados

Os sete testes do Roshambo foram aprovados. A pipeline só disponibiliza o pacote depois de concluir as tarefas de compilação e teste.

## 01:26–01:41 — Roshambo: artefato WAR

O artefato publicado contém o arquivo roshambo ponto war, que será consumido pela pipeline de entrega contínua.

## 01:41–02:00 — Roshambo: release e deploy

A publicação do artefato acionou automaticamente a release dois. O stage Desenvolvimento terminou com sucesso e implantou o WAR no App Service com Tomcat.

## 02:00–02:25 — Roshambo: aplicação funcionando

Na aplicação publicada, o texto mostra a versão dois. Uma rodada do jogo demonstra que a página está funcionando após o deploy.

## 02:25–02:46 — API: código e rota de validação

O segundo exercício é uma API .NET oito com Oracle. O Program.cs disponibiliza Swagger, a rota de health e a rota wellcome, usada para verificar a versão publicada.

## 02:46–03:02 — API: commit versionado

As configurações e os scripts também são versionados. Este commit ajusta o Log Stream do App Service Linux e aciona a execução final de integração contínua.

## 03:02–03:25 — API: jobs e conexão de serviço

A pipeline clássica possui os jobs Infra e BuildAndTest. O Azure CLI usa a conexão de serviço federada. A senha Oracle é referenciada por variável secreta, sem ficar no código.

## 03:25–03:44 — API: CI automática concluída

A execução quinze foi disparada automaticamente. Primeiro a infraestrutura é preparada. Depois são executados restore, build, testes e publicação do pacote da API.

## 03:44–03:59 — API: testes .NET 8

Os quatorze testes da API foram aprovados usando .NET oito. Esses testes verificam o código; a consulta real ao banco será demonstrada na aplicação publicada.

## 03:59–04:15 — API: artefato ZIP

O artefato api contém o ZIP da publicação. A release recebe esse pacote da build, mantendo a ligação entre o código compilado e a versão implantada.

## 04:15–04:34 — API: release automática

A release três foi acionada pela build quinze e concluiu o deploy no stage Desenvolvimento. A hospedagem utiliza App Service Linux com runtime .NET oito.

## 04:34–04:47 — API: versão publicada

A rota wellcome responde com a versão dois, confirmando que a alteração chegou à aplicação publicada.

## 04:47–05:24 — API: Swagger e consulta Oracle

O Swagger apresenta os endpoints da API. Ao executar o GET de Empresa, a aplicação consulta o Oracle e devolve HTTP duzentos. A lista está vazia porque ainda não há registros cadastrados. Esse teste comprova o acesso real ao banco, além do funcionamento do processo web.

## 05:24–05:47 — PetClinic: trigger e infraestrutura YAML

No PetClinic, a definição fica no arquivo azure pipelines YAML. O trigger monitora a branch main. As variáveis identificam a conexão Azure, o grupo de recursos, o plano e o nome da aplicação.

## 05:47–06:05 — PetClinic: build e deploy no YAML

Os stages são criarInfra, BuildApp e DeployApp, com dependências sequenciais. Maven compila e testa com Java dezessete, o JaCoCo gera cobertura e o JAR é publicado como artefato antes do deploy.

## 06:05–06:21 — PetClinic: commit que disparou a execução

O commit registra as alterações no código e na configuração. Ele atualiza a mensagem para a versão três e inclui a publicação da cobertura na pipeline.

## 06:21–06:40 — PetClinic: três stages concluídos

A execução de ID treze foi disparada automaticamente pelo commit. Os três stages terminaram com sucesso, desde o provisionamento da infraestrutura até o deploy e a verificação HTTP.

## 06:40–06:58 — PetClinic: resultados dos testes

Foram quarenta e três testes aprovados e dois ignorados por dependerem de Docker. Os testes com H2 foram executados, sem falhas.

## 06:58–07:16 — PetClinic: relatório JaCoCo gerado pelo build

Este é o relatório real do JaCoCo gerado pelo Maven. A tabela mostra vinte e uma linhas não cobertas de um total de duzentas e setenta e sete. Isso corresponde a noventa e dois vírgula quarenta e dois por cento de cobertura de linhas.

## 07:16–07:35 — PetClinic: JAR e rastreabilidade

Os artefatos incluem o relatório de cobertura e a pasta petclinic. Nela estão app ponto jar e commit ponto txt, que identifica o commit usado para produzir o pacote.

## 07:35–07:54 — PetClinic: versão publicada

Na aplicação publicada, a página inicial exibe a versão três. O PetClinic utiliza Java Spring e banco H2, conforme o exercício de pipeline YAML.

## 07:54–08:11 — PetClinic: consulta de proprietário

A página de proprietário apresenta os dados e os animais cadastrados no exemplo. Essa navegação demonstra o funcionamento da aplicação após a implantação.

## 08:11–08:26 — PetClinic: veterinários

A consulta de veterinários também está funcionando no ambiente publicado. Assim, a validação inclui páginas funcionais da aplicação, além da página inicial.

## 08:26–08:42 — Encerramento

Os três exercícios demonstram o fluxo desde o versionamento até a aplicação disponível: commit, disparo automático, compilação, testes, artefatos, deploy e validação. As execuções e os recursos permanecem disponíveis para conferência no Azure DevOps.

