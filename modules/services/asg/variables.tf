variable "ecs_ssm_path" {
  description = "Path to the ECS-optimized AMI in SSM Parameter Store"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for ECS instances"
  type        = string
}

variable "ecs_sg_id" {
  description = "Security Group ID for ECS instances"
  type        = string
}

variable "ecs_iam_instance_profile_name" {
  description = "IAM Instance Profile name for ECS instances"
  type        = string
}

variable "efs_name" {
  description = "ID of the EFS filesystem"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS Cluster to join"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs for the Auto Scaling Group"
  type        = string
  }

variable "target_group_arn" {
  description = "Target Group ARN for ECS service load balancing"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of ECS instances"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of ECS instances"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of ECS instances"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Additional tags to apply to ASG instances"
  type        = map(string)
  default     = {}
}
