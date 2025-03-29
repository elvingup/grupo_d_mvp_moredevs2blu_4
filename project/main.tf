// Este arquivo eh responsavel por definir os modulos utilizados no projeto.

// Modulo VPC:
// - source: caminho do modulo VPC que sera utilizado para criar a infraestrutura de rede.
// - project_region: regiao da AWS onde a VPC sera criada, definida pela variavel "project_region".
// - project_name: nome do projeto, utilizado para nomear recursos, definido pela variavel "project_name".

// Modulo Load Balancer:
// - source: caminho do modulo de load balancer que sera utilizado para configurar o balanceamento de carga da aplicacao.
// - vpc_id: identificador da VPC onde o load balancer sera criado, obtido como saida do modulo VPC.
// - sn_pub01: identificador da primeira sub-rede publica, obtido como saida do modulo VPC.
// - sn_pub02: identificador da segunda sub-rede publica, obtido como saida do modulo VPC.

module "vpc" {
    source = "./modules/vpc"
    project_region = var.project_region
    project_name = var.project_name
}

module "loadbalancer" {
    source = "./modules/loadbalancer"
    vpc_id = module.vpc.vpc_id
    sn_pub01 = module.vpc.sn_pub01
    sn_pub02 = module.vpc.sn_pub02
}

module "frontend" {
    source = "./modules/frontend"
    vpc_id = module.vpc.vpc_id
    sn_pub01 = module.vpc.sn_priv01
}

module "backend" {
    source = "./modules/backend"
    vpc_id = module.vpc.vpc_id
    sn_pub01 = module.vpc.sn_priv02
}