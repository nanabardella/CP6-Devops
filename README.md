# 🚀 CP6 — Azure DevOps

### Integração contínua, entrega contínua e aplicações publicadas

**Giovanna Bardella Gomes · RM561439**

**Erick Takeshi Andrade Nakajune · RM566059** 

Três exercícios de CI/CD, reunindo versionamento no Azure Repos, testes automatizados, publicação de artefatos, provisionamento e deploy no Azure App Service.

**Fluxo demonstrado:** alteração no código → commit → CI automática → testes → artefato → deploy → aplicação funcionando.

---

## 🎬 Vídeo demonstrativo

### [▶ Assistir à demonstração no YouTube](https://www.youtube.com/watch?v=m7vJ0xjkZos)

[![Demonstração da CP6 no YouTube](https://img.youtube.com/vi/m7vJ0xjkZos/hqdefault.jpg)](https://www.youtube.com/watch?v=m7vJ0xjkZos)

O vídeo apresenta os commits e suas execuções automáticas, as configurações das pipelines, os testes, os artefatos, as releases e a validação das aplicações.

Também estão disponíveis em `entrega/` o vídeo em MP4 e o pacote de evidências.

## 🌐 Aplicações

| Aplicação | Tecnologias | Acesso |
|---|---|---|
| **Roshambo** | Java 11 · JSP · Maven · Tomcat | [Abrir jogo](https://roshambo-rm561439-cp6.azurewebsites.net/roshambo/) |
| **PriceWhisper API** | .NET 8 · Entity Framework Core · Oracle · Swagger | [Abrir Swagger](https://api-dotnet-rm561439-cp6.azurewebsites.net/swagger/index.html) |
| **PetClinic** | Java 17 · Spring Boot · H2 · Maven · JaCoCo | [Abrir PetClinic](https://petclinic-rm561439-cp6.azurewebsites.net/) |

## ⚙️ Pipelines implementadas

### 1. Roshambo — pipeline clássica

O commit na branch `main` dispara a pipeline de CI. Maven compila o projeto, executa os testes e gera o WAR. O artefato publicado aciona a release clássica, que provisiona a hospedagem e implanta a aplicação no App Service.

`Azure Repos → Maven e testes → roshambo.war → Release → App Service / Tomcat`

### 2. API .NET com Oracle — pipeline clássica

O job **Infra** prepara os objetos Oracle, o App Service Linux e as configurações de ambiente. Após seu sucesso, o job **BuildAndTest** executa restore, build, testes e publicação do ZIP. O artefato aciona a release de deploy.

`Azure Repos → Infra → Restore / Build / Test → ZIP → Release → App Service / .NET 8`

A conexão Azure utiliza federação de identidade. A senha Oracle é armazenada como variável secreta e aplicada ao ambiente, sem ser incluída no código.

### 3. PetClinic — pipeline YAML

A definição está em `projetos/petclinic/azure-pipelines.yml`, com os stages **criarInfra**, **BuildApp** e **DeployApp**. O build publica o JAR, o identificador do commit e o relatório de cobertura. O deploy termina com uma validação HTTP da aplicação.

`Azure Repos → criarInfra → BuildApp + JaCoCo → app.jar → DeployApp → validação HTTP`

## ✅ Resultados verificados

| Exercício | Commit | CI automática | Deploy | Testes |
|---|---|---|---|---|
| Roshambo | `675383e` | [Build 12 — sucesso](https://dev.azure.com/Azure-DevOps-561439/c9d9c297-b65b-487b-adab-92cd6b80a815/_build/results?buildId=12) | Release 2 — sucesso | **7 aprovados** |
| API .NET + Oracle | `368cd49` | [Build 15 — sucesso](https://dev.azure.com/Azure-DevOps-561439/c9d9c297-b65b-487b-adab-92cd6b80a815/_build/results?buildId=15) | Release 3 — sucesso | **14 aprovados** |
| PetClinic YAML | `7783202` | [Build 13 — sucesso](https://dev.azure.com/Azure-DevOps-561439/c9d9c297-b65b-487b-adab-92cd6b80a815/_build/results?buildId=13) | DeployApp — sucesso | **43 aprovados, 2 ignorados** |

- **Roshambo:** versão 2 publicada e página respondendo HTTP 200.
- **API:** versão 2 disponível em `/wellcome`; Swagger, `/health`, `/api/Empresa` e `/api/Usuario` responderam HTTP 200. As duas últimas rotas realizaram consultas ao Oracle e retornaram listas vazias.
- **PetClinic:** versão 3 publicada, com validação das páginas inicial, de proprietário e de veterinários. Cobertura de linhas pelo JaCoCo: **92,42%**. Os dois testes ignorados dependem de Docker.

## 📁 Organização do repositório

```text
.
├── README.md
├── ORIGENS.md
├── projetos/
│   ├── roshambo/
│   ├── api-dotnet-oracle/
│   └── petclinic/
├── configuracao/
│   └── pipelines-classicas.json
├── evidencias/
│   ├── evidencias-azure.json
│   ├── validacao-completa.json
│   ├── petclinic-testes.json
│   └── repositorios-cp6.json
└── entrega/
    ├── CP6-Azure-DevOps-RM561439.mp4
    └── CP6-Azure-DevOps-RM561439.zip
```

## 🔗 Projeto e repositórios das pipelines

[Abrir o projeto CP6 — Azure DevOps](https://dev.azure.com/Azure-DevOps-561439/c9d9c297-b65b-487b-adab-92cd6b80a815)

Este repositório reúne os códigos, as configurações e os arquivos de entrega. As pipelines demonstradas utilizam os repositórios abaixo, que preservam os commits e o histórico das execuções:

- [cp6-roshambo](https://dev.azure.com/Azure-DevOps-561439/c9d9c297-b65b-487b-adab-92cd6b80a815/_git/cp6-roshambo)
- [cp6-pricewhisper](https://dev.azure.com/Azure-DevOps-561439/c9d9c297-b65b-487b-adab-92cd6b80a815/_git/cp6-pricewhisper)
- [cp6-petclinic](https://dev.azure.com/Azure-DevOps-561439/c9d9c297-b65b-487b-adab-92cd6b80a815/_git/cp6-petclinic)

Para disparar uma nova execução, faça a alteração no repositório correspondente e envie o commit à branch `main`.

## 💻 Como executar localmente

### Pré-requisitos

| Ferramenta | Utilização |
|---|---|
| Git | Clonar e versionar os projetos |
| JDK 11 e Maven | Compilar e testar o Roshambo |
| Apache Tomcat 9 | Executar o WAR do Roshambo |
| SDK .NET 8 | Compilar, testar e executar a API |
| Oracle acessível e credenciais de desenvolvimento | Executar as consultas da API |
| JDK 17 | Executar o PetClinic com o Maven Wrapper |

Clone o repositório consolidado:

```powershell
git clone "https://dev.azure.com/Azure-DevOps-561439/CP6%20-%20Azure%20DevOps/_git/CP6%20-%20Azure%20DevOps" cp6-azure-devops
cd cp6-azure-devops
```

O acesso ao repositório requer permissão na organização Azure DevOps. Em cada bloco abaixo, comece na raiz da cópia clonada.

### Roshambo

Selecione o JDK 11 e execute:

```powershell
cd projetos/roshambo
mvn clean verify
```

O comando executa os testes e gera `target/roshambo.war`. Para executar localmente, copie esse arquivo para `webapps` de uma instalação do Tomcat 9 e inicie o servidor. Com a variável `CATALINA_HOME` apontando para essa instalação:

```powershell
Copy-Item .\target\roshambo.war "$env:CATALINA_HOME\webapps\"
& "$env:CATALINA_HOME\bin\catalina.bat" run
```

Abra **http://localhost:8080/roshambo/** e escolha pedra, papel ou tesoura.

### API .NET com Oracle

```powershell
cd projetos/api-dotnet-oracle
dotnet restore .\pricewhisper-usuarios.Tests\pricewhisper-usuarios.Tests.csproj
dotnet test .\pricewhisper-usuarios.Tests\pricewhisper-usuarios.Tests.csproj --configuration Release
```

Para executar a API, configure a conexão no ambiente local. Os valores abaixo são exemplos e devem ser substituídos pelas credenciais do seu ambiente:

```powershell
$env:ConnectionStrings__OracleConnection = "Data Source=SERVIDOR:1521/SERVICO;User ID=USUARIO;Password=SENHA;"
$env:Swagger__Enabled = "true"
dotnet run --no-launch-profile --project .\pricewhisper-usuarios.API\pricewhisper-usuarios.API.csproj --urls http://localhost:5080
```

Abra **http://localhost:5080/swagger/index.html**. O banco precisa conter as tabelas `Empresas` e `Usuarios` com a estrutura esperada pela API. Na implementação em nuvem, o job **Infra** faz essa preparação.

- `/health`: verifica se o processo web responde.
- `/wellcome`: mostra a mensagem de versão.
- `/api/Empresa` e `/api/Usuario`: executam consultas ao Oracle.

As senhas devem ficar nas configurações do ambiente e nas variáveis secretas do Azure DevOps.

### PetClinic

Selecione o JDK 17 e execute no Windows:

```powershell
cd projetos/petclinic
.\mvnw.cmd clean verify
.\mvnw.cmd spring-boot:run
```

No Linux ou macOS, use `./mvnw` no lugar de `mvnw.cmd`. Abra **http://localhost:8080/** para navegar em **Find Owners** e **Veterinarians**. O perfil padrão utiliza H2.

O relatório JaCoCo é gerado em `target/site/jacoco/index.html`. Os testes específicos de outros bancos podem ser ignorados quando Docker não estiver disponível.

## ☁️ Como configurar o CI/CD no Azure DevOps

### 1. Preparar o projeto e os recursos

1. Crie um projeto Azure DevOps e disponibilize cada aplicação em seu próprio repositório, usando as pastas de `projetos/` como origem.
2. Tenha uma assinatura Azure e os grupos de recursos utilizados pelas aplicações. Na demonstração: `rg-cp6-roshambo`, `rg-api-dotnet` e `rg-cp6-petclinic`.
3. Crie uma conexão **Azure Resource Manager** chamada `sc-azure-cp6`, com federação de identidade e permissões nos grupos necessários.
4. Autorize o uso da conexão pelas pipelines.
5. Configure um agente com Git, Azure CLI, Maven, JDK 11/17 e .NET 8. Na demonstração, o agente Windows pertence ao pool `CP6-Local`.

Os nomes dos App Services são globais. Para reproduzir em outra conta, escolha nomes disponíveis e ajuste as variáveis e tarefas de deploy.

### 2. Criar a CI clássica do Roshambo

No editor clássico, selecione o repositório Roshambo e a branch `main`. Configure as tarefas na sequência:

| Tarefa | Configuração principal |
|---|---|
| Maven | `pom.xml`, goals `clean verify`, JDK 11 e publicação JUnit |
| Copy Files | Copiar `target/*.war` para `$(Build.ArtifactStagingDirectory)`, com flatten folders |
| Publish Build Artifacts | Publicar o diretório de staging como artefato `roshambo` |

Em **Triggers**, habilite **Continuous integration** para a branch `main`.

### 3. Criar a CI clássica da API

Crie os jobs **Infra** e **BuildAndTest**, configurando o segundo para depender do sucesso do primeiro.

No job **Infra**, utilize **Azure CLI**, conexão `sc-azure-cp6`, tipo Bash/Shell e script `pricewhisper-usuarios.API/infra-app.sh`. Os argumentos são referências às variáveis:

```text
"$(DbHost)" "$(DbPort)" "$(DbSid)" "$(DbUser)" "$(DbPass)"
```

| Variável | Conteúdo |
|---|---|
| `DbHost` | Servidor Oracle |
| `DbPort` | Porta Oracle, por exemplo `1521` |
| `DbSid` | Nome do serviço utilizado na conexão |
| `DbUser` | Usuário Oracle |
| `DbPass` | Senha, marcada como **secret** |
| `LOCATION` | Região Azure, por exemplo `eastus` |
| `NOME_WEBAPP` | Nome do App Service da API |

No job **BuildAndTest**, instale o SDK .NET 8 e configure restore, build, teste do projeto `pricewhisper-usuarios.Tests`, publish da API em ZIP e publicação do artefato `api`. Habilite CI na branch `main`.

### 4. Criar as releases clássicas

Crie uma release para o Roshambo e outra para a API. Em cada uma:

1. Adicione como artefato a respectiva pipeline de build, com alias `ci`.
2. Habilite o **Continuous deployment trigger** para `main`.
3. Configure o stage **Desenvolvimento** e a tarefa **Azure App Service deploy**.
4. Selecione a conexão Azure e o App Service correspondente.
5. Salve e acompanhe a release criada após uma build bem-sucedida.

| Aplicação | Tipo de hospedagem | Pacote da release |
|---|---|---|
| Roshambo | Linux, Tomcat 9 / Java 11 | `$(System.DefaultWorkingDirectory)/ci/roshambo/*.war` |
| API | Linux, `DOTNETCORE|8.0` | `$(System.DefaultWorkingDirectory)/ci/api/**/*.zip` |

Na release do Roshambo, a tarefa de infraestrutura prepara o plano F1 e o App Service antes do deploy. Na API, a infraestrutura já foi preparada pela CI; o comando de inicialização é `dotnet pricewhisper-usuarios.API.dll`.

### 5. Criar a pipeline YAML do PetClinic

No repositório próprio do PetClinic, mantenha `azure-pipelines.yml` na raiz. Em **Pipelines → New pipeline → Azure Repos Git**, selecione esse repositório e use a opção de arquivo YAML existente.

Ajuste a conexão Azure, o pool, a região, o grupo de recursos e o nome da aplicação. Depois salve e execute. A cópia em `projetos/petclinic/azure-pipelines.yml` neste repositório consolidado corresponde à definição usada no repositório próprio da aplicação.

### 6. Validar o fluxo completo

1. Altere uma mensagem visível em `index.jsp`, `Program.cs` ou `welcome.html`.
2. Faça commit e push na branch `main` do repositório da aplicação.
3. Confira o disparo automático e o commit associado à execução.
4. Mostre os jobs, testes e artefatos gerados.
5. Acompanhe a release clássica ou o stage `DeployApp` até o sucesso.
6. Abra a aplicação e confirme a nova mensagem. Na API, execute também uma consulta Oracle pelo Swagger.

No PetClinic, preserve o prefixo `CP6 - RM561439` da mensagem usada na verificação HTTP, ou ajuste a verificação no YAML para o identificador do novo ambiente.

## 🧩 Pontos de atenção

| Situação | Verificação |
|---|---|
| Pipeline aguardando na fila | Agente online e autorizado para o projeto |
| Editor ou release clássica indisponível | Opções de criação de pipelines clássicas nas configurações da organização e do projeto |
| Erro na conexão Azure | Permissões e autorização da service connection |
| Falha Oracle | Servidor, porta, serviço, usuário, variável secreta e acesso de rede |
| Swagger indisponível | Configuração `Swagger__Enabled=true` e deploy da versão atual |
| Aplicação ainda com versão anterior | Commit da build, artefato consumido e resultado do deploy |

## 📚 Materiais da atividade

| Material | Slides |
|---|---|
| 01 — Azure Pipelines | 14 a 87 |
| 03 — Azure Pipelines API .NET com Oracle | 4 a 50 |
| 05 — Construindo Pipelines com YAML | 12 a 63 |

Os códigos têm como base os repositórios indicados nos materiais da disciplina. As referências e os commits usados nesta consolidação estão em `ORIGENS.md`.
#
