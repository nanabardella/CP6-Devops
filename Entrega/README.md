# CP6 - Azure DevOps

**Aluna:** Giovanna Bardella Gomes — RM561439

## Arquivos

- `CP6-Azure-DevOps-RM561439.mp4`: demonstração dos três exercícios, com explicações em legendas.
- `CP6-Azure-DevOps-RM561439.zip`: evidências das execuções e arquivos de configuração.

## Projeto e aplicações

- [Projeto Azure DevOps](https://dev.azure.com/Azure-DevOps-561439/c9d9c297-b65b-487b-adab-92cd6b80a815)
- [Roshambo](https://roshambo-rm561439-cp6.azurewebsites.net/roshambo/)
- [API .NET — Swagger](https://api-dotnet-rm561439-cp6.azurewebsites.net/swagger/index.html)
- [PetClinic](https://petclinic-rm561439-cp6.azurewebsites.net/)

## Execuções validadas

| Exercício | Commit | CI | Deploy | Testes |
|---|---|---|---|---|
| Roshambo | `675383e` | [Build 12](https://dev.azure.com/Azure-DevOps-561439/c9d9c297-b65b-487b-adab-92cd6b80a815/_build/results?buildId=12), automática, sucesso | Release 2, sucesso | 7 aprovados |
| API .NET com Oracle | `368cd49` | [Build 15](https://dev.azure.com/Azure-DevOps-561439/c9d9c297-b65b-487b-adab-92cd6b80a815/_build/results?buildId=15), automática, sucesso | Release 3, sucesso | 14 aprovados |
| PetClinic YAML | `7783202` | [Build 13](https://dev.azure.com/Azure-DevOps-561439/c9d9c297-b65b-487b-adab-92cd6b80a815/_build/results?buildId=13), automática, sucesso | Stage DeployApp, sucesso | 43 aprovados, 2 ignorados por dependerem de Docker |

As aplicações foram validadas com HTTP 200. A API consultou as tabelas de empresas e usuários no Oracle. O PetClinic apresentou 92,42% de cobertura de linhas pelo JaCoCo.

## Recursos utilizados

Azure Repos, pipelines clássicas de CI e CD, pipeline YAML com stages, agente Windows no pool `CP6-Local`, Maven, Java 11 e 17, .NET 8, conexão Azure federada e App Services Linux em planos F1. O Roshambo gera WAR, a API gera ZIP e o PetClinic gera JAR. A senha Oracle é armazenada como variável secreta.

## Repositórios

- [cp6-roshambo](https://dev.azure.com/Azure-DevOps-561439/c9d9c297-b65b-487b-adab-92cd6b80a815/_git/cp6-roshambo)
- [cp6-pricewhisper](https://dev.azure.com/Azure-DevOps-561439/c9d9c297-b65b-487b-adab-92cd6b80a815/_git/cp6-pricewhisper)
- [cp6-petclinic](https://dev.azure.com/Azure-DevOps-561439/c9d9c297-b65b-487b-adab-92cd6b80a815/_git/cp6-petclinic)

Os projetos têm como base os repositórios indicados nos materiais da disciplina, com o histórico e os autores originais preservados.
