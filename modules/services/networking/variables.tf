variable "vpc_id" {
  description = "VPC ID for subnet creation"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "public_subnet_a_cidr" {
  type        = string
  description = "CIDR block for public subnet A"
}

variable "public_subnet_b_cidr" {
  type        = string
  description = "CIDR block for public subnet B"
}

variable "private_subnet_ecs_cidr" {
  type        = string
  description = "CIDR block for private ECS subnet"
}

variable "private_subnet_db_a_cidr" {
  type        = string
  description = "CIDR block for private DB subnet A"
}

variable "private_subnet_db_b_cidr" {
  type        = string
  description = "CIDR block for private DB subnet B"
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
