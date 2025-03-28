# grupo_d_mvp_moredevs2blu_4
Projeto de exercício de criação de um MVP utilizando terraform para executar uma instância EC2 no ambiente da AWS.

## Explicação do projeto
O projeto grupo_d_mvp_moredevs2blu_4 tem como objetivo criar um MVP (produto minimamente viavel) que provisiona uma instancia EC2 na AWS utilizando o Terraform.

O modulo vpc eh responsavel por criar a infraestrutura de rede para a instancia EC2. Eh criada uma VPC com um bloco de IP, e duas sub-redes privadas em alguma regiao da AWS.

O modulo loadbalancer eh responsavel por criar um Security Group e uma instancia EC2 que sera utilizada como um load balancer. A instancia eh criada em uma sub-rede privada da VPC e tem como imagem a imagem mais recente da Amazon Linux 2.

O arquivo main.tf eh o arquivo principal do projeto e eh responsavel por declarar os modulos vpc e loadbalancer. O arquivo outputs.tf eh responsavel por declarar as saídas dos modulos.

O arquivo providers.tf eh responsavel por declarar o provedor AWS para o Terraform.

O arquivo variables.tf eh responsavel por declarar as variaveis que serao utilizadas no projeto.

Abaixo segue um resumo dos resources declarados nos arquivos:

- module.vpc:
  - aws_vpc
  - aws_subnet
  - aws_internet_gateway
  - aws_route_table
  - aws_route_table_association
- module.loadbalancer:
  - aws_security_group
  - aws_instance
  - aws_network_interface

## Referências
- https://github.com/elvingup/iac-modelos.git
- https://interesting-stinger-3d2.notion.site/Modulo-7-Aula-5-Stacks-Templates-Modulos-Aninhados-Provisioner-1ba0065d4ed280a08f08ed8e0b40baa8
