###MONITORING MODULE-------------------------------
variable "cloudtrail_log_group_name" {
  description = "Name of the CloudWatch Log Group for CloudTrail"
  type        = string
}

variable "cloudtrail_bucket_arn" {
  description = "ARN of the S3 bucket for CloudTrail logs"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all IAM resources"
  type        = map(string)
  default     = {}
}