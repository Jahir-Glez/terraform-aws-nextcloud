
resource "aws_subnet" "public_subnet_test" {
  vpc_id            = aws_vpc.vpc_example.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = "${var.region}a"
  tags = var.tags
}

resource "aws_subnet" "private_subnet_test_ecs" {
  vpc_id            = aws_vpc.vpc_example.id
  cidr_block        = var.private_subnet_ecs_cidr
  availability_zone = "${var.region}a"
  tags = var.tags
}

resource "aws_subnet" "private_subnet_test_db" {
  vpc_id            = aws_vpc.vpc_example.id
  cidr_block        = var.private_subnet_db_cidr
  availability_zone = "${var.region}a"
  tags = var.tags 
}


