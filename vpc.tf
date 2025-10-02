###VPC
resource "aws_vpc" "vpc_example" {
  cidr_block = var.vpc_cidr
  tags = var.tags
}