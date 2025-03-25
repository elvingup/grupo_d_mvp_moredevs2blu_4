provider "aws" {
    region = "us-west-1"
}

resource "aws_vpc" "elvintao-vpc" {
  cidr_block       = "172.102.0.0/16"
  
  tags = {
    Name = "elvintao-vpc"
  }
}

resource "aws_subnet" "subnet-private-1c" {
  vpc_id     = aws_vpc.elvintao-vpc.id
  cidr_block = "172.102.1.0/24"
  availability_zone = "us-west-1c"

  tags = {
    Name = "subnet-private-1c"
  }
}

resource "aws_subnet" "subnet-private-1d" {
  vpc_id     = aws_vpc.elvintao-vpc.id
  cidr_block = "172.102.1.0/24"
  availability_zone = "us-west-1d"

  tags = {
    Name = "subnet-private-1d"
  }
}

resource "aws_subnet" "subnet-public-1c" {
  vpc_id     = aws_vpc.elvintao-vpc.id
  cidr_block = "172.102.1.0/24"
  availability_zone = "us-west-1c"

  tags = {
    Name = "subnet-public-1c"
  }
}

resource "aws_subnet" "subnet-public-1d" {
  vpc_id     = aws_vpc.elvintao-vpc.id
  cidr_block = "172.102.1.0/24"
  availability_zone = "us-west-1d"

  tags = {
    Name = "subnet-public-1d"
  }
}