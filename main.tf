resource "aws_vpc" "pri_vpc" {
  cidr_block           = "172.2.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.pri_vpc.id
  cidr_block = "172.2.0.0/24"

  tags = {
    Name = "sub1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.pri_vpc.id
  cidr_block = "172.2.1.0/24"

  tags = {
    Name = "sub2"
  }
}
