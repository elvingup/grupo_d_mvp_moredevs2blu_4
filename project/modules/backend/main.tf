data "aws_ami" "elvintao_ami_backend_vm" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "name"
      values = [ "al2023-ami-2023.*-x86_64" ]
    }
}

resource "aws_vpc_security_group_egress_rule" "elvintao_backend_egress_sg_rule" {
  security_group_id = "sg_loadbalancer_id"
  cidr_ipv4   = module.frontend.frontend_private_ip
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "elvintao_backend_ingress_tcp80_sg_rule" {
  security_group_id = "sg_loadbalancer_id"
  cidr_ipv4   = module.frontend.frontend_private_ip
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "elvintao_backend_ingress_tcp22_sg_rule" {
  security_group_id = "sg_loadbalancer_id"
  cidr_ipv4   = module.frontend.frontend_private_ip
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

resource "aws_network_interface" "elvintao_backend_network_interface" {
  subnet_id = var.sn_priv02
  tags = {
    Name = "elvintao_backend_network_interface"
  }
}

resource "aws_instance" "elvintao_backend_vm" {
    ami           = data.aws_ami.elvintao_ami_backend_vm
    instance_type = "t2.micro"            

    subnet_id     = var.sn_priv02

    tags = {
        Name = "elvintao_backend_vm"
    }
}