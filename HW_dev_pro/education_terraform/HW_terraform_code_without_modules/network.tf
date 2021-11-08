resource "aws_vpc" "vpc_for_dev_pro" {
  cidr_block              = var.cidr_block_for_vpc
  tags = {
    Name                  = "vpc_for_dev_pro"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id                  = aws_vpc.vpc_for_dev_pro.id

  tags = {
    Name                  = "gateway"
  }
}

data "aws_route_table" "selected" {
  vpc_id                  = aws_vpc.vpc_for_dev_pro.id
}

resource "aws_route" "internet" {
  route_table_id          = data.aws_route_table.selected.id
  destination_cidr_block  = "0.0.0.0/0"
  gateway_id              = aws_internet_gateway.gw.id
}

resource "aws_subnet" "public_1a" {
  cidr_block              = var.cidr_block_for_public_subnet_1a
  vpc_id                  = aws_vpc.vpc_for_dev_pro.id
  availability_zone       = var.subnet_1a
  tags = {
    Name                  = "subnet_1a"
  }
}

resource "aws_subnet" "public_1b" {
  cidr_block              = var.cidr_block_for_public_subnet_1b
  vpc_id                  = aws_vpc.vpc_for_dev_pro.id
  availability_zone       = var.subnet_1b
  tags = {
    Name                  = "subnet_1b"
  }
}