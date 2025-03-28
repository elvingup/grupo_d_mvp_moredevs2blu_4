// Este arquivo define o provedor AWS para a configuracao do Terraform.

// Explicacao das propriedades:
// - provider: especifica o provedor que o Terraform ira usar para gerenciar os recursos.
// - region: define a regiao da AWS onde os recursos serao criados. Nesta configuracao, a regiao eh determinada pela variavel "project_region".

provider "aws" {
    region = var.project_region
}