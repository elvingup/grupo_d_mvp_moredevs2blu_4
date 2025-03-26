provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "elvintao_vpc" {
  cidr_block = "172.200.0.0/16"
  tags = {
    Name = "elvintao-vpc"
  }
}

resource "aws_subnet" "sn_priv01" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.200.1.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "elvintao-sn_priv01"
  }
}
resource "aws_subnet" "sn_priv02" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.200.2.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "elvintao-sn_priv02"
  }
}
resource "aws_subnet" "sn_pub01" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.200.3.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "elvintao-sn_pub01"
  }
}
resource "aws_subnet" "sn_pub02" {
  vpc_id = aws_vpc.elvintao_vpc.id
  cidr_block = "172.200.4.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "elvintao-sn_pub02"
  }
}