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

# RASCUNHO DO EC2 NGINX

data "aws_ami" "imagem_ec2" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "name"
      values = [ "al2023-ami-2023.*-x86_64" ]
    }
}

resource "aws_security_group" "dart_nginx_sg" {
    vpc_id = aws_vpc.dart_vpc.id
    name = "dart_nginx_sg"
    tags = {
      Name = "dart-nginx_sg"
    }
}

resource "aws_vpc_security_group_egress_rule" "dart_egress_sg_rule" {
  security_group_id = aws_security_group.dart_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
} 

resource "aws_vpc_security_group_ingress_rule" "dart_ingress_80_sg_rule" {
  security_group_id = aws_security_group.dart_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}
resource "aws_vpc_security_group_ingress_rule" "dart_ingress_22_sg_rule" {
  security_group_id = aws_security_group.dart_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

resource "aws_network_interface" "dart_nginx_ei" {
  subnet_id = aws_subnet.sn_pub01.id
  tags = {
    Name = "dart_nginx_ei"
  }
}

resource "aws_instance" "dart_nginx_ec2" {
  instance_type = "t3.micro"
  ami = data.aws_ami.imagem_ec2.id
  vpc_security_group_ids = [ aws_security_group.dart_nginx_sg.id ]
  
  network_interface {
    network_interface_id = aws_network_interface.dart_nginx_ei
    device_index = 0
  }
  associate_public_ip_address = true
  tags = {
    Name = "dart-nginx_ec2"
  }
}


