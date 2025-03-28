provider "aws" {
    region = var.project_region
}


terraform {
    backend "s3" {
        bucket = "${var.project_name}_terraform_state"
        key    = "terraform.tfstate"
        region = var.project_region
    }
}
