provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "elvintao_vpc" {
  cidr_block = "172.102.0.0/16"
  tags = {
    Name = "elvintao-vpc"
  }
}

resource "aws_subnet" "sn_priv01" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.102.1.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "elvintao-sn_priv01"
  }
}
resource "aws_subnet" "sn_priv02" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.102.2.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "elvintao-sn_priv02"
  }
}
resource "aws_subnet" "sn_pub01" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.102.3.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "elvintao-sn_pub01"
  }
}
resource "aws_subnet" "sn_pub02" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.102.4.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "elvintao-sn_pub02"
  }
}

# SUBNET PUBLIC 
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

# EC2 NGINX
resource "aws_security_group" "elvintao-sg-nginx" {
  name        = "elvintao-sg-nginx"
  
  vpc_id      = aws_vpc.elvintao_vpc.id

  tags = {
    Name = "elvintao-sg-nginx"
  }
}

