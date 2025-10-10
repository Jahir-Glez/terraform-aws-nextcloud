### VPC------------------------------------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  tags                 = var.tags
  enable_dns_support   = true
  enable_dns_hostnames = true
}
### INTERNET GATEWAY---------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = var.tags
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = var.tags
}

resource "aws_route_table_association" "public_rt_assoc_a" {
  subnet_id      = var.public_subnet_a_id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_assoc_b" {
  subnet_id      = var.public_subnet_b_id
  route_table_id = aws_route_table.public_rt.id
}
### NAT GATEWAY-----------------------------------------
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags   = var.tags
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_a_id
  tags          = var.tags
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = var.tags
}

resource "aws_route_table_association" "private_rt_assoc_ecs" {
  subnet_id      = var.private_subnet_ecs_id
  route_table_id = aws_route_table.private_rt.id
}

###S3-------------------------------------------------------------

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private_rt.id]
  tags              = var.tags
}
