resource "aws_iam_role" "ecs_instance_role" {
  name               = "ecsInstanceRole"
  assume_role_policy = jsonencode(var.role_policy)
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_policy_attachment" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = var.ecs_instance_role_policy
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecsInstanceProfile"
  role = aws_iam_role.ecs_instance_role.name
}

### ECS TASK EXECUTION ROLE FOR SECRETS MANAGER ACCESS ------------------------------
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
  tags = var.tags
} 

data "aws_caller_identity" "account" {}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "ecs_secrets_manager_policy" {
  name        = "SecretsManagerAccessPolicy"
  role        = aws_iam_role.ecs_task_execution_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = "arn:aws:secretsmanager:${var.region}:${data.aws_caller_identity.account.account_id}:secret:db_credentials-*"
      }
    ]
  })
}

### CLOUD TRAIL ROLE ------------------------------
resource "aws_iam_role" "cloudtrail_role" {
  name               = "CloudTrailRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
      }
    ]
  })
  tags = var.tags
}

resource "aws_iam_policy" "cloudtrail_policy" {
  name = "CloudTrailPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = [
          "${aws_cloudwatch_log_group.nextcloud_log_group.arn}:*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetBucketAcl",
          "s3:PutObject"
        ]
        Resource = [
          "${aws_s3_bucket.nextcloud_s3_bucket_logs.arn}",
          "${aws_s3_bucket.nextcloud_s3_bucket_logs.arn}/AWSLogs/${data.aws_caller_identity.account.account_id}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudtrail_role_policy_attachment" {
  role       = aws_iam_role.cloudtrail_role.name
  policy_arn = aws_iam_policy.cloudtrail_policy.arn
}

