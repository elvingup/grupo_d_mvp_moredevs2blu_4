// Este arquivo define um recurso AWS S3 Bucket para armazenar o estado do Terraform.

// Explicacao das propriedades:
// - bucket: o nome do bucket S3, que eh criado como uma combinacao do nome do projeto e "_terraform_state".
// - acl: define o controle de acesso do bucket. Neste caso, eh configurado como "private" para garantir que somente usuarios autorizados possam acessar o bucket.
// - force_destroy: quando configurado como "true", permite que o bucket seja destruido mesmo que haja objetos dentro dele.
// - versioning: uma configuracao que permite manter diferentes versoes dos objetos dentro do bucket. Aqui, o versionamento esta desativado (enabled = false).

resource "aws_s3_bucket" "bucket-terraform-state" {
    bucket = "elvintao-terraform-state"
    acl = "private"
    force_destroy = true
    versioning {
        enabled = false
    }
}