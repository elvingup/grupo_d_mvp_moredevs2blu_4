# Este arquivo eh responsavel por criar a infraestrutura de rede da aplicacao em uma VPC na AWS.

# Cria um VPC para a aplicacao
# A VPC eh criada com bloco de IP 
resource "aws_vpc" "elvintao_vpc" {
  cidr_block = "172.102.0.0/16"
  tags = {
    Name = "${var.project_name}_vpc"
  }
}

# Este recurso cria uma sub-rede privada na VPC
resource "aws_subnet" "sn_priv01" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.102.1.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "${var.project_name}-sn_priv01"
  }
}

# Este recurso cria uma sub-rede privada na VPC
# A sub-rede é alocada no bloco CIDR 
# e está localizada na zona de disponibilidade especificada
resource "aws_subnet" "sn_priv02" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.102.2.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "${var.project_name}-sn_priv02"
  }
}

# Este recurso cria uma sub-rede pública na VPC
# A sub-rede é alocada no bloco CIDR especificado
# e está localizada na zona de disponibilidade especificada
resource "aws_subnet" "sn_pub01" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.102.3.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "${var.project_name}-sn_pub01"
  }
}

# Este recurso cria uma sub-rede pública na VPC
# A sub-rede é alocada no bloco CIDR especificado
# e está localizada na zona de disponibilidade especificada
resource "aws_subnet" "sn_pub02" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.102.4.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "${var.project_name}-sn_pub02"
  }
}

# INTERNET GATEWAY E ROUTE TABLE 

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.elvintao_vpc.id
  tags = {
    Name = "elvintao-igw" 
  }
}

resource "aws_route_table" "route_pub" {
  vpc_id = aws_vpc.elvintao_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "elvintao-routetable"
  }
}

resource "aws_route_table_association" "pub01assoc" {
  subnet_id = aws_subnet.sn_pub01.id
  route_table_id = aws_route_table.route_pub.id
}
resource "aws_route_table_association" "pub02assoc" {
  subnet_id = aws_subnet.sn_pub02.id
  route_table_id = aws_route_table.route_pub.id
}