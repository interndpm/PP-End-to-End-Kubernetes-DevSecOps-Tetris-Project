data "aws_vpc" "vpc" {
  tags = {
    Name = "Jenkins-vpc"
  }
}

data "aws_internet_gateway" "igw" {
  tags = {
    Name = "igw-name"
  }
}

data "aws_subnet" "subnet" {
  vpc_id = data.aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"  # Example of additional filter
}

data "aws_security_group" "sg-default" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Name = "security-group-name"
  }
}

resource "aws_subnet" "public-subnet2" {
  vpc_id                  = data.aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet-name2
  }
}

resource "aws_route_table" "rt2" {
  vpc_id = data.aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.rt-name2
  }
}

resource "aws_route_table_association" "rt-association2" {
  route_table_id = aws_route_table.rt2.id
  subnet_id      = aws_subnet.public-subnet2.id
}
