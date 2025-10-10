# PUBLIC SUBNETS
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_a_cidr
  availability_zone = "${var.region}a"
  tags              = var.tags
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_b_cidr
  availability_zone = "${var.region}b"
  tags              = var.tags
}

# PRIVATE ECS SUBNET
resource "aws_subnet" "private_subnet_ecs" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_ecs_cidr
  availability_zone = "${var.region}a"
  tags              = var.tags
}

# PRIVATE DB SUBNETS
resource "aws_subnet" "private_subnet_db_a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_db_a_cidr
  availability_zone = "${var.region}a"
  tags              = var.tags
}

resource "aws_subnet" "private_subnet_db_b" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_db_b_cidr
  availability_zone = "${var.region}b"
  tags              = var.tags
}

# DB Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "nextcloud-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_db_a.id, aws_subnet.private_subnet_db_b.id]
  tags       = var.tags
}
