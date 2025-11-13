provider "aws" {
  region = "eu-west-3"
}

data "aws_region" "current" {}

resource "aws_vpc" "kubernetes" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "kubernetes"
  }
}
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.kubernetes.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_region.current.name}a"

  tags = {
    Name = "kubernetes-public"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.kubernetes.id

  tags = {
    Name = "kubernetes-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.kubernetes.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}