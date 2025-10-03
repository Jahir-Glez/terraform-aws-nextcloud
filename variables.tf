## region --------------------------------
variable "region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}

### VPC --------------------------------  
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

### subnets --------------------------------
variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}
variable "private_subnet_ecs_cidr" {
  description = "The CIDR block for the ECS private subnet"
  default     = "10.0.2.0/24"
}
variable "private_subnet_db_cidr"{
  description = "The CIDR block for the DB private subnet"
  default = "10.0.3.0/24"
}

## tags--------------------------------------------
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

### EC2 --------------------------------------
variable "instance_type" {
  description = "The type of instance to use"
  default     = "t3.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  default     = "ami-052064a798f08f0d3"
}

### ECS ------------------------------
variable "ecs_ssm_path" {
  description = "The SSM parameter path for the ECS optimized AMI"
  default = "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended/image_id"
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  default     = "NextcloudECSCluster"
}

#Container--------------------------------------

variable "nextcloud_image" {
  description = "The Docker image for Nextcloud"
  default     = "nextcloud:27-apache"
}

variable "container_name" {
  description = "The name of the Nextcloud container"
  default     = "nextcloud"
}

### AIM Role ------------------------------

variable "role_policy" {
  description = "The policy document for the IAM role"
  default     = {
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  }
}

variable "ecs_instance_role_policy"{
  description = "The ARN of the policy to attach to the ECS instance role"
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
