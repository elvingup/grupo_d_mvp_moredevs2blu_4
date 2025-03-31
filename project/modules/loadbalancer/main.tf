// Este arquivo eh responsavel por configurar o load balancer para a aplicacao na AWS.

# Este data eh responsavel por buscar a imagem da AWS que sera utilizada para criar a instancia do EC2.

# Explicacao das propriedades:
# - most_recent: busca a imagem mais recente da AWS com base na propriedade "owners" e "filter".
# - owners: eh a propriedade que define os proprietarios da imagem. Neste caso, eh a amazon.
# - filter: eh a propriedade que define o filtro de busca da imagem. Neste caso, eh o nome da imagem que eh "al2023-ami-2023.*-x86_64".
data "aws_ami" "elvintao_ami_ec2" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "name"
      values = [ "al2023-ami-2023.*-x86_64" ]
    }
}

# Este recurso eh responsavel por criar um Security Group para a instancia do EC2.
# O Security Group sera criado na VPC especificada pela variavel "vpc_id".
# O nome do Security Group sera "elvintao_nginx_sg".
# A tag "Name" sera adicionada ao Security Group com o valor "elvintao_nginx_sg".
resource "aws_security_group" "elvintao_nginx_sg" {
    vpc_id = var.vpc_id
    name = "elvintao_nginx_sg"
    tags = {
      Name = "elvintao_nginx_sg"
    }
}

# Este recurso eh responsavel por criar uma regra de saída para o Security Group.
# A regra de saída sera criada no Security Group especificado pela variavel "security_group_id".
# A propriedade "cidr_ipv4" define o bloco de IP que tera acesso a regra de saída.
# A propriedade "ip_protocol" define o protocolo de rede que sera utilizado na regra de saída.
# Neste caso, eh utilizado o valor "-1" que eh o protocolo qualquer.
resource "aws_vpc_security_group_egress_rule" "elvintao_egress_sg_rule" {
  security_group_id = aws_security_group.elvintao_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

# Este recurso eh responsavel por criar uma regra de entrada para o Security Group.
# A regra de entrada sera criada no Security Group especificado pela variavel "security_group_id".
# A propriedade "cidr_ipv4" define o bloco de IP que tera acesso a regra de entrada.
# A propriedade "ip_protocol" define o protocolo de rede que sera utilizado na regra de entrada.
# A propriedade "from_port" define a porta de inicio da regra de entrada.
# A propriedade "to_port" define a porta de fim da regra de entrada.
resource "aws_vpc_security_group_ingress_rule" "elvintao_ingress_tcp80_sg_rule" {
  security_group_id = aws_security_group.elvintao_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# Este recurso eh responsavel por criar uma regra de entrada para o Security Group.
# A regra de entrada sera criada no Security Group especificado pela variavel "security_group_id".
# A propriedade "cidr_ipv4" define o bloco de IP que tera acesso a regra de entrada.
# A propriedade "ip_protocol" define o protocolo de rede que sera utilizado na regra de entrada.
# A propriedade "from_port" define a porta de inicio da regra de entrada.
# A propriedade "to_port" define a porta de fim da regra de entrada.
resource "aws_vpc_security_group_ingress_rule" "elvintao_ingress_tcp22_sg_rule" {
  security_group_id = aws_security_group.elvintao_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

# Este recurso eh responsavel por criar uma regra de entrada para o Security Group.
# A regra de entrada sera criada no Security Group especificado pela variavel "security_group_id".
# A propriedade "cidr_ipv4" define o bloco de IP que tera acesso a regra de entrada.
# A propriedade "ip_protocol" define o protocolo de rede que sera utilizado na regra de entrada.
# A propriedade "from_port" define a porta de inicio da regra de entrada.
# A propriedade "to_port" define a porta de fim da regra de entrada.
resource "aws_vpc_security_group_ingress_rule" "elvintao_ingress_udp80_sg_rule" {
  security_group_id = aws_security_group.elvintao_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "udp"
  from_port   = 80
  to_port     = 80
}

# Este recurso eh responsavel por criar uma regra de entrada para o Security Group.
# A regra de entrada sera criada no Security Group especificado pela variavel "security_group_id".
# A propriedade "cidr_ipv4" define o bloco de IP que tera acesso a regra de entrada.
# A propriedade "ip_protocol" define o protocolo de rede que sera utilizado na regra de entrada.
# A propriedade "from_port" define a porta de inicio da regra de entrada.
# A propriedade "to_port" define a porta de fim da regra de entrada.
resource "aws_vpc_security_group_ingress_rule" "elvintao_ingress_udp22_sg_rule" {
  security_group_id = aws_security_group.elvintao_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "udp"
  from_port   = 22
  to_port     = 22
}

# Este recurso eh responsavel por criar uma interface de rede.
# A interface de rede sera criada na subnet especificada pela variavel "subnet_id".
# A propriedade "subnet_id" define a subnet na qual a interface de rede sera criada.
resource "aws_network_interface" "elvintao_nginx_network_interface" {
  subnet_id = var.sn_pub01
  tags = {
    Name = "elvintao_nginx_network_interface"
  }
}

# §§§
# Instância da VM NGINX 
# Este recurso eh responsavel por criar uma instancia do EC2.
# A instancia sera criada com o tipo de instancia especificado pela propriedade "instance_type".
# A propriedade "ami" define a imagem da AWS que sera utilizada para criar a instancia.
# A propriedade "subnet_id" define a subnet na qual a instancia sera criada.
# A propriedade "vpc_security_group_ids" define os Security Groups que serao associados a instancia.
# A propriedade "associate_public_ip_address" define se a instancia tera um endereco IP publico associado.
# A propriedade "tags" define as tags que serao adicionadas a instancia.

resource "aws_instance" "elvintao_nginx_ec2" {
  # Tipo de instancia do EC2.
  instance_type = "t3.micro"
  
  # Imagem da AWS que sera utilizada para criar a instancia.
  ami = data.aws_ami.elvintao_ami_ec2.id
  
  # Subnet na qual a instancia sera criada.
  subnet_id = var.sn_pub01
  
  # Security Groups que serao associados a instancia.
  vpc_security_group_ids = [ aws_security_group.elvintao_nginx_sg.id ]
  
  # Define se a instancia tera um endereco IP publico associado.
  associate_public_ip_address = true
  
  # Tags que serao adicionadas a instancia.
  tags = {
    Name = "elvintao_nginx_ec2"
  }
}
# §§§