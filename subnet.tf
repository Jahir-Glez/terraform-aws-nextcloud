###Subnet
resource "aws_subnet" "public_subnet_example" {
  vpc_id            = aws_vpc.vpc_example.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = "${var.region}a"
  tags = var.tags
}