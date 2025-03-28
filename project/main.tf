module "vpc" {
    source = "./modules/vpc"
}

module "loadbalancer" {
    source = "./modules/loadbalancer"
}