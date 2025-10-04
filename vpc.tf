###VPC
resource "aws_vpc" "nextcloud_vpc" {
  cidr_block           = var.vpc_cidr
  tags                 = var.tags
  enable_dns_support   = true
  enable_dns_hostnames = true
}
###Internet Gateway -------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.nextcloud_vpc.id
  tags   = var.tags
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.nextcloud_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = var.tags
}

resource "aws_route_table_association" "public_rt_assoc_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_assoc_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}

##NAT Gateway -------------------------------
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags   = var.tags
}
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_a.id
  tags          = var.tags
}
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.nextcloud_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = var.tags
}
resource "aws_route_table_association" "private_rt_assoc_ecs" {
  subnet_id      = aws_subnet.private_subnet_ecs.id
  route_table_id = aws_route_table.private_rt.id
}
#S3 -----------------------------------------------------------
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = aws_vpc.nextcloud_vpc.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [
    aws_route_table.private_rt.id
  ]
  tags = var.tags
}
