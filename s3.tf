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
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_logs_config"{
  bucket = aws_s3_bucket.secrets_manager_bucket_logs.id
  rule {
    id = "log-expiration"
    status = "Enabled"

    expiration{
      days = 30
    }
  }
} 

# resource "aws_s3_bucket_policy" "secrets_manager_bucket_policy" {
#   bucket = aws_s3_bucket.secrets_manager_bucket_logs.id

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Sid    = "AllowCloudTrailAccess"
#         Effect = "Allow"
#         Principal = {
#           Service = "cloudtrail.amazonaws.com"
#         }
#         Action = [
#           "s3:PutObject"
#         ]
#         Resource = [
#           "${aws_s3_bucket.secrets_manager_bucket_logs.arn}/AWSLogs/${data.aws_caller_identity.account.account_id}/*"
#         ]
#         Condition = {
#           StringEquals = {
#             "s3:x-amz-acl" = "bucket-owner-full-control"
#           }
#         }
#       }
#     ]
#   })
# }

resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy" {
  bucket = aws_s3_bucket.secrets_manager_bucket_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Allow CloudTrail to write to this bucket
      {
        Sid      = "AWSCloudTrailAclCheck"
        Effect   = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action   = "s3:GetBucketAcl"
        Resource = aws_s3_bucket.secrets_manager_bucket_logs.arn
      },
      {
        Sid      = "AWSCloudTrailWrite"
        Effect   = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.secrets_manager_bucket_logs.arn}/AWSLogs/${data.aws_caller_identity.account.account_id}/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}
