provider "aws" {
    region = var.project_region
}


terraform {
    backend "s3" {
        bucket = "elvintao_terraform_state"
    }
}
