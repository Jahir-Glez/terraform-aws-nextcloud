### DEFAULT --------------------------------------------------------
variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default = "nextcloud"
}

variable "task_family" {
  description = "Family name of the ECS task definition"
  type        = string
  default     = "nextcloud"
}

variable "task_cpu" {
  description = "Task CPU units"
  type        = string
  default     = "512"
}

variable "task_memory" {
  description = "Task memory in MB"
  type        = string
  default     = "1024"
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default = "nextcloud"
}

variable "nextcloud_image" {
  description = "Container image to use for Nextcloud"
  type        = string
  default = "nextcloud:27-apache"
}

variable "container_cpu" {
  description = "CPU units for the container"
  type        = number
  default     = 512
}

variable "container_memory" {
  description = "Memory in MB for the container"
  type        = number
  default     = 1024
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 80
}

variable "nextcloud_data_host_path" {
  description = "Host path for Nextcloud data volume"
  type        = string
  default = "/mnt/ecs/data"
}

variable "nextcloud_config_host_path" {
  description = "Host path for Nextcloud config volume"
  type        = string
  default = "/mnt/ecs/config"
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
  default     = "nextcloud_service"
}

variable "desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 1
}

variable "health_check_grace_period_seconds" {
  description = "Grace period for ECS health check"
  type        = number
  default     = 300
}

###------------------------------------------------------------------
variable "db_secret_arn" {
  description = "ARN of the Secrets Manager secret for the database password"
  type        = string
}

variable "db_host" {
  description = "Database host address"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name for object storage"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "execution_role_arn" {
  description = "IAM role ARN for ECS task execution"
  type        = string
}

variable "lb_listener_dependencies" {
  description = "Dependencies on ALB listeners for ECS service"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}