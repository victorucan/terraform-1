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
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.pri_vpc.id

  tags = {
    Name = "gw"
  }
}
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.pri_vpc.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "route_table"
  }
}

resource "aws_route_table_association" "as1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "as2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_key_pair" "key" {
  key_name   = "mykey"
  public_key = file("/home/ubuntu/.ssh/mykey.pub")
}

resource "aws_instance" "web" {
  instance_type = "t3.micro"
  ami           = "ami-0ff39345bd62c82a5"

  tags = {
    Name = "nginx"
  }
  key_name  = aws_key_pair.key.id
  subnet_id = aws_subnet.subnet1.id
  user_data = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }
}