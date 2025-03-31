data "aws_ami" "elvintao_ami_frontend_vm" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "name"
      values = [ "al2023-ami-2023.*-x86_64" ]
    }
}

resource "aws_vpc_security_group_egress_rule" "elvintao_frontend_egress_sg_rule" {
  security_group_id = "sg_loadbalancer_id"
  cidr_ipv4   = "loadbalancer_cidr_block"
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "elvintao_frontend_ingress_tcp80_sg_rule" {
  security_group_id = "sg_loadbalancer_id"
  cidr_ipv4   = "loadbalancer_cidr_block"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "elvintao_frontend_ingress_tcp22_sg_rule" {
  security_group_id = "sg_loadbalancer_id"
  cidr_ipv4   = "loadbalancer_cidr_block"
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

resource "aws_network_interface" "elvintao_frontend_network_interface" {
  subnet_id = var.sn_priv01
  tags = {
    Name = "elvintao_frontend_network_interface"
  }
}

resource "aws_instance" "elvintao_frontend_vm" {
    ami           = data.aws_ami.elvintao_ami_frontend_vm
    instance_type = "t2.micro"            

    subnet_id     = var.sn_priv01

    tags = {
        Name = "elvintao_frontend_vm"
    }
}