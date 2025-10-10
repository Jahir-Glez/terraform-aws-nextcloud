variable "secretsmanager_secret_arn" {
  description = "ARN of the Secrets Manager secret"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group for the ALB"
  type        = string
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
}

variable "ecs_ssm_path" {
  description = "SSM path for ECS secrets or parameters"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the ECS instances"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of instances in ASG"
  type        = number
}

variable "max_size" {
  description = "Max number of instances in ASG"
  type        = number
}

variable "min_size" {
  description = "Min number of instances in ASG"
  type        = number
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

# variable "task_cpu" {
#   description = "CPU units for the ECS task"
#   type        = number
# }

# variable "task_memory" {
#   description = "Memory for the ECS task (in MiB)"
#   type        = number
# }

variable "nextcloud_image" {
  description = "Docker image for Nextcloud container"
  type        = string
}

variable "container_cpu" {
  description = "CPU units for the Nextcloud container"
  type        = number
}

variable "container_memory" {
  description = "Memory for the container"
  type        = number
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
}

variable "db_name" {
  description = "Name of the RDS database"
  type        = string
}

variable "db_username" {
  description = "Username for the RDS database"
  type        = string
}

variable "db_password_secrets_manager" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
}

# variable "db_port" {
#   description = "Port the RDS database listens on"
#   type        = number
# }

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "instance_class" {
  description = "Instance class for RDS"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage for RDS (in GB)"
  type        = number
}

variable "zone_name" {
  description = "Hosted zone name in Route 53"
  type        = string
}

variable "subdomain_fqdn" {
  description = "Fully qualified domain name for subdomain"
  type        = string
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_a_cidr" {
  description = "CIDR block for public subnet A"
  type        = string
}

variable "public_subnet_b_cidr" {
  description = "CIDR block for public subnet B"
  type        = string
}

variable "private_subnet_ecs_cidr" {
  description = "CIDR block for ECS private subnet"
  type        = string
}

variable "private_subnet_db_a_cidr" {
  description = "CIDR block for DB private subnet A"
  type        = string
}

variable "private_subnet_db_b_cidr" {
  description = "CIDR block for DB private subnet B"
  type        = string
}
