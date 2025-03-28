module "vpc" {
    source = "./modules/vpc"
    project_region = var.project_region
    project_name = var.project_name
}

module "loadbalancer" {
    source = "./modules/loadbalancer"
}