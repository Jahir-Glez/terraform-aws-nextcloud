variable "topic_name" {
  description = "Name of the SNS topic for alert notifications"
  type        = string
}

variable "alert_email" {
  description = "Email address to subscribe to SNS topic for alerts"
  type        = string
}

variable "region" {
  description = "AWS region for resource deployment"
  type        = string
}

variable "secret_arn" {
  description = "ARN of the secret stored in AWS Secrets Manager"
  type        = string
}

variable "cloudtrail_s3_bucket_name" {
  description = "Name of the S3 bucket used to store CloudTrail logs"
  type        = string
}

variable "log_retention_days" {
  description = "Number of days to retain CloudWatch logs"
  type        = number
}

variable "log_s3_expiration_days" {
  description = "Number of days before S3 log files expire"
  type        = number
}

variable "tags" {
  description = "Map of tags to apply to all resources"
  type        = map(string)
}
