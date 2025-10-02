###VPC
resource "aws_vpc" "nextcloud_vpc" {
  cidr_block = var.vpc_cidr
  tags = var.tags
}