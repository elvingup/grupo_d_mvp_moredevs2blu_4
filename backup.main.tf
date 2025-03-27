# PROVIDER & RESOURCE VPC & RESOURCES SUBNETS 
provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "elvintao_vpc" {
  cidr_block = "172.102.0.0/16"
  tags = {
    Name = "elvintao_vpc"
  }
}

resource "aws_subnet" "sn_priv01" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.102.1.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "elvintao_sn_priv01"
  }
}
resource "aws_subnet" "sn_priv02" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.102.2.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "elvintao_sn_priv02"
  }
}
resource "aws_subnet" "sn_pub01" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.102.3.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "elvintao_sn_pub01"
  }
}
resource "aws_subnet" "sn_pub02" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.102.4.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "elvintao_sn_pub02"
  }
}

# SUBNET PUBLIC 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.elvintao_vpc.id
  tags = {
    Name = "elvintao_igw" 
  }
}

resource "aws_route_table" "route_pub" {
  vpc_id = aws_vpc.elvintao_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "elvintao_routetable"
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

data "aws_ami" "elvintao_ami_ec2" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "name"
      values = [ "al2023-ami-2023.*-x86_64" ]
    }
}

resource "aws_security_group" "elvintao_nginx_sg" {
    vpc_id = aws_vpc.elvintao_vpc.id
    name = "elvintao_nginx_sg"
    tags = {
      Name = "elvintao_nginx_sg"
    }
}

resource "aws_vpc_security_group_egress_rule" "elvintao_egress_sg_rule" {
  security_group_id = aws_security_group.elvintao_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
} 

resource "aws_vpc_security_group_ingress_rule" "elvintao_ingress_80_sg_rule" {
  security_group_id = aws_security_group.elvintao_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}
resource "aws_vpc_security_group_ingress_rule" "elvintao_ingress_22_sg_rule" {
  security_group_id = aws_security_group.elvintao_nginx_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

resource "aws_network_interface" "elvintao_nginx_network_interface" {
  subnet_id = aws_subnet.sn_pub01.id
  tags = {
    Name = "elvintao_nginx_network_interface"
  }
}

resource "aws_instance" "elvintao_nginx_ec2" {
  instance_type = "t3.micro"
  ami = data.aws_ami.elvintao_ami_ec2.id
  vpc_security_group_ids = [ aws_security_group.elvintao_nginx_sg.id ]
  
  network_interface {
    network_interface_id = aws_network_interface.elvintao_nginx_network_interface
    device_index = 0
  }
  associate_public_ip_address = true
  tags = {
    Name = "elvintao_nginx_ec2"
  }
}
