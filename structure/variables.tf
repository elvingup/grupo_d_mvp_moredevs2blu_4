# Este arquivo eh responsavel por definir as variaveis que serao usadas no modulo de infraestrutura como o nome do projeto e a regiao da AWS onde a infra sera criada.
# o terraform apply vai exigir que o usuario informe os valores respectivos a cada variavel.

variable "project_region" {
    type = string
}

variable "project_name" {
    type=string
}