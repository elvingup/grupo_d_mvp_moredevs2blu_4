# Este arquivo eh responsavel por definir as variaveis que serao usadas no modulo de loadbalancer como o nome do projeto, a regiao da AWS onde a infra sera criada, o ID da VPC e as sub-redes publicas.

variable "vpc_id" {
    type = string
}

variable "sn_pub01" {
    type = string
}

variable "sn_pub02" {
    type = string
}
