# CloudTrail Role--------------------------------------------------------------
resource "aws_iam_role" "cloudtrail_role" {
  name               = "CloudTrailRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
      }
    ]
  })
  tags = var.tags
}

data "aws_caller_identity" "account" {}

resource "aws_iam_policy" "cloudtrail_policy" {
  name = "CloudTrailPolicy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = [
          "arn:aws:logs:${var.region}:${data.aws_caller_identity.account.account_id}:log-group:${var.cloudtrail_log_group_name}:*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "s3:*"
        ],
        Resource = [
          "${var.cloudtrail_bucket_arn}",
          "${var.cloudtrail_bucket_arn}/AWSLogs/${data.aws_caller_identity.account.account_id}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudtrail_role_policy_attachment" {
  role       = aws_iam_role.cloudtrail_role.name
  policy_arn = aws_iam_policy.cloudtrail_policy.arn
}
