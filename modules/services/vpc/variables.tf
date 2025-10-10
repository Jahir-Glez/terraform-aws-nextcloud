variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_a_id" {
  description = "ID of the public subnet A"
  type        = string
}

variable "public_subnet_b_id" {
  description = "ID of the public subnet B"
  type        = string
}

variable "private_subnet_ecs_id" {
  description = "ID of the private ECS subnet"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
