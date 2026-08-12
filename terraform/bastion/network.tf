locals {
  vpc_name              = "${var.project_name}-${var.environment}-bastion-vpc"
  subnet_name           = "${var.project_name}-${var.environment}-bastion-public"
  internet_gateway_name = "${var.project_name}-${var.environment}-bastion-igw"
  route_table_name      = "${var.project_name}-${var.environment}-bastion-public-rt"
}

resource "aws_vpc" "bastion" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = local.vpc_name
  })
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.bastion.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = local.subnet_name
  })
}

resource "aws_internet_gateway" "bastion" {
  vpc_id = aws_vpc.bastion.id

  tags = merge(var.tags, {
    Name = local.internet_gateway_name
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.bastion.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bastion.id
  }

  tags = merge(var.tags, {
    Name = local.route_table_name
  })
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
