output "logs_bucket_name" {
  description = "Name of the S3 bucket used for CloudTrail logs"
  value       = aws_s3_bucket.cloudtrail_bucket_logs.id
}

output "cloudtrail_bucket_arn"{
  description = "ARN of the s3 bucker used for cloudtrail logs"
  value = aws_s3_bucket.cloudtrail_bucket_logs.arn
}
output "cloudtrail_s3_bucket"{
  description = "S3 bucket for cloudtrail, Bucket parameter"
  value = aws_s3_bucket.cloudtrail_bucket_logs.bucket
}
