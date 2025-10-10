# Logs bucket for CloudTrail
resource "aws_s3_bucket" "cloudtrail_bucket_logs" {
  bucket = "${var.cloudtrail_s3_bucket_name}-logs"
  tags   = var.tags
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_logs_config" {
  bucket = aws_s3_bucket.cloudtrail_bucket_logs.id

  rule {
    id     = "log-expiration"
    status = "Enabled"

    expiration {
      days = var.log_s3_expiration_days
    }
  }
}

# CloudTrail permissions for logs bucket
resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy" {
  bucket = aws_s3_bucket.cloudtrail_bucket_logs.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AWSCloudTrailAclCheck"
        Effect    = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action   = "s3:GetBucketAcl"
        Resource = aws_s3_bucket.cloudtrail_bucket_logs.arn
      },
      {
        Sid       = "AWSCloudTrailWrite"
        Effect    = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.cloudtrail_bucket_logs.arn}/AWSLogs/${data.aws_caller_identity.account.account_id}/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}

data "aws_caller_identity" "account" {}
