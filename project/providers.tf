// Este arquivo define o provedor AWS e a configuracao do backend S3 para o Terraform.

// Explicacao das propriedades do backend S3:
// - bucket: o nome do bucket S3 onde o estado do Terraform sera armazenado. Eh criado como uma combinacao do nome do projeto e "_terraform_state".
// - key: o caminho do arquivo dentro do bucket S3 onde o estado do Terraform sera armazenado. Neste caso, eh "terraform.tfstate".
// - region: a regiao AWS onde o bucket S3 esta localizado. Eh determinada pela variavel "project_region".

provider "aws" {
    region = "us-west-1"
}

terraform {
    backend "s3" {
        bucket = "us-west-1_terraform_state"
        key    = "terraform.tfstate"
        region = var.project_region
    }
}
