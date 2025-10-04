###### PUBLIC-------------------------------------------------
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.nextcloud_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = "${var.region}a"
  tags              = var.tags
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.nextcloud_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "${var.region}b"
  tags              = var.tags
}
####### PRIVATE ECS-------------------------------------------------
resource "aws_subnet" "private_subnet_ecs" {
  vpc_id            = aws_vpc.nextcloud_vpc.id
  cidr_block        = var.private_subnet_ecs_cidr
  availability_zone = "${var.region}a"
  tags              = var.tags
}
####### PRIVATE DB-------------------------------------------------
resource "aws_subnet" "private_subnet_db_a" {
  vpc_id            = aws_vpc.nextcloud_vpc.id
  cidr_block        = var.private_subnet_db_cidr
  availability_zone = "${var.region}a"
  tags              = var.tags
}

resource "aws_subnet" "private_subnet_db_b" {
  vpc_id            = aws_vpc.nextcloud_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "${var.region}b"
  tags              = var.tags
}

resource "aws_db_subnet_group" "nextcloud_db_subnet_group" {
  name       = "nextcloud-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_db_a.id, aws_subnet.private_subnet_db_b.id]
  tags       = var.tags
}


