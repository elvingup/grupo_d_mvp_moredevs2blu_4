// Este arquivo define as variaveis que serao usadas no modulo de infraestrutura.
// As variaveis incluem o nome do projeto e a regiao da AWS onde a infraestrutura sera criada.
// A variavel "project_region" define a regiao padrao como "us-west-1".
// A variavel "project_name" define o nome padrao do projeto como "elvintao".

variable "project_region" {
    default = "us-west-1"
    type = string
}

variable "project_name" {
    default="elvintao"
    type=string
}