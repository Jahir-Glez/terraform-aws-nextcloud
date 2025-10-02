## region 
variable "region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}

### VPC and Subnet
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

##tags
variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default = {
    name        = "nextcloud_test"
    environment = "Test"
    owner       = "Jahir"
    project     = "Nextcloud"
    team      = "DevOps"
  }
}

### EC2

variable "instance_type" {
  description = "The type of instance to use"
  default     = "t3.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  default     = "ami-08982f1c5bf93d976"
} 

