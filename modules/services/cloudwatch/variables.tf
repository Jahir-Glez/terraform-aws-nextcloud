variable "region" {
  description = "AWS region"
  type        = string
}

variable "secret_arn" {
  description = "ARN of the Secrets Manager secret to monitor"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic ARN to notify when alarm is triggered"
  type        = string
}

variable "cloudtrail_s3_bucket" {
  description = "S3 bucket where CloudTrail stores logs"
  type        = string
}

variable "cloudtrail_role_arn" {
  description = "IAM role ARN used by CloudTrail to write logs to CloudWatch"
  type        = string
}

variable "log_retention_days" {
  description = "Number of days to retain logs in CloudWatch"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to apply to CloudTrail"
  type        = map(string)
  default     = {}
}
