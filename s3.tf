resource "aws_s3_bucket" "nextcloud_s3_bucket" {
  bucket = var.s3_bucket_name
  tags   = var.tags
  #   lifecycle {
  #     prevent_destroy = true
  #   }

}


resource "aws_s3_bucket_policy" "nextcloud_access" {
  bucket = aws_s3_bucket.nextcloud_s3_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowEC2RoleAccess"
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_role.ecs_instance_role.arn
        }
        Action = [
          "s3:*"
        ]
        Resource = [
          aws_s3_bucket.nextcloud_s3_bucket.arn,
          "${aws_s3_bucket.nextcloud_s3_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket" "secrets_manager_bucket_logs" {
  bucket = "${var.s3_bucket_name}-logs"
  tags   = var.tags
  #   lifecycle {
  #     prevent_destroy = true
  #   }
  lifecycle_rule {
    id      = "log-expiration"
    enabled = true

    expiration {
      days = 90
    }
  }
}

resource "aws_s3_bucket_policy" "secrets_manager_bucket_policy" {
  bucket = aws_s3_bucket.secrets_manager_bucket_logs.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowCloudTrailAccess"
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_role.cloudtrail_role.arn
        }
        Action = [
          "s3:PutObject"
        ]
        Resource = [
          "${aws_s3_bucket.secrets_manager_bucket_logs.arn}/AWSLogs/${data.aws_caller_identity.account}/*"
        ]
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}