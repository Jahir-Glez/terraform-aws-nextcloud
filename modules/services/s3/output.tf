output "nextcloud_s3_bucket_name" {
  description = "Name of the main Nextcloud S3 bucket"
  value       = aws_s3_bucket.nextcloud_s3_bucket.id
}

