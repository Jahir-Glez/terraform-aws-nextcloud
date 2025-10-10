resource "aws_s3_bucket" "nextcloud_s3_bucket" {
  bucket = var.s3_bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_policy" "nextcloud_access" {
  bucket = aws_s3_bucket.nextcloud_s3_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowEC2RoleAccess"
        Effect    = "Allow"
        Principal = {
          AWS = var.ecs_instance_role_arn
        }
        Action    = ["s3:*"]
        Resource  = [
          aws_s3_bucket.nextcloud_s3_bucket.arn,
          "${aws_s3_bucket.nextcloud_s3_bucket.arn}/*"
        ]
      }
    ]
  })
}

