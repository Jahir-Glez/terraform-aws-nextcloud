### MAIN BUCKET
variable "s3_bucket_name" {
  description = "Base name for the S3 buckets (main and logs)"
  type        = string
}

variable "ecs_instance_role_arn" {
  description = "IAM role ARN for EC2 instances (ECS) that access the main S3 bucket"
  type        = string
}


###GENERAL

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
