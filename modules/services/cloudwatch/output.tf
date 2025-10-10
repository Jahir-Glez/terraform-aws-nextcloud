output "cloudtrail_log_group_name" {
  description = "CloudWatch Log Group name"
  value       = aws_cloudwatch_log_group.secrets_manager_log_group.name
}

output "cloudtrail_name" {
  description = "Name of the CloudTrail trail"
  value       = aws_cloudtrail.secrets_manager_trail.name
}

output "alarm_name" {
  description = "Name of the CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.secret_access_alarm.alarm_name
}
