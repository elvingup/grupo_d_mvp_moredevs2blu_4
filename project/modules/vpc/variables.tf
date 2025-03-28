# Este arquivo eh responsavel por definir as variaveis que serao usadas no modulo de infraestrutura como o nome do projeto e a regiao da AWS onde a infra sera criada.
variable "project_region" {
    default = "us-west-1"
    type = string
}

variable "project_name" {
    default="elvintao"
    type=string
}
