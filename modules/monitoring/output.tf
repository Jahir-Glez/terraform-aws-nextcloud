output "sns_topic_arn" {
  description = "ARN of the SNS topic used for alert notifications"
  value       = module.sns_alerts.sns_topic_arn
}

output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group used for secrets monitoring"
  value       = module.cloudwatch_alert.cloudtrail_log_group_name
}

output "cloudtrail_iam_role_arn" {
  description = "ARN of the IAM role used by CloudTrail"
  value       = module.iam.cloudtrail_role_arn
}

output "cloudtrail_bucket_arn" {
  description = "ARN of the S3 bucket used for CloudTrail logs"
  value       = module.s3.cloudtrail_bucket_arn
}
