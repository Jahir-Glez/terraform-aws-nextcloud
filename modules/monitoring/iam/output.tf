output "cloudtrail_role_arn" {
  description = "ARN of the CloudTrail role"
  value       = aws_iam_role.cloudtrail_role.arn
}
