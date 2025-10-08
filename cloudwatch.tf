resource "aws_cloudwatch_log_group" "secrets_manager_log_group" {
  name              = "ecs/secrets_manager_logs"
  retention_in_days = 30
}

resource "aws_cloudtrail" "secrets_manager_trail"{
    name                          = "secretscloudTrail"
    s3_bucket_name                = aws_s3_bucket.secrets_manager_bucket_logs.bucket
    include_global_service_events = true
    is_multi_region_trail         = true
    enable_log_file_validation    = true
    cloud_watch_logs_group_arn = "arn:aws:logs:${var.region}:${data.aws_caller_identity.account.account_id}:log-group:ecs/secrets_manager_logs:*"
    cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_role.arn
    depends_on                    = [
        aws_iam_role_policy_attachment.cloudtrail_role_policy_attachment,
        aws_cloudwatch_log_group.secrets_manager_log_group
        ]
    tags                          = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "secret_access_filter" {
    name           = "SecretAccessFilter"
    log_group_name = aws_cloudwatch_log_group.secrets_manager_log_group.name
    pattern        = "{ (($.eventName = GetSecretValue) || ($.eventName = DescribeSecret)) && ($.requestParameters.secretId = \"${aws_secretsmanager_secret.db_secret.arn}\") }"
    
    metric_transformation {
        name      = "SecretAccessCount"
        namespace = "Nextcloud/Secrets"
        value     = "1"
    }
}

resource "aws_cloudwatch_metric_alarm" "secret_access_alarm"{
    alarm_name = "SecretAccessAlarm"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = 1
    metric_name = aws_cloudwatch_log_metric_filter.secret_access_filter.metric_transformation[0].name
    namespace = aws_cloudwatch_log_metric_filter.secret_access_filter.metric_transformation[0].namespace
    period = 60
    statistic = "Sum"
    threshold = 0

    alarm_description = "Alarm when there is any access to Secrets Manager secrets"
    alarm_actions = [aws_sns_topic.secrets_manager_notifi.arn]
}


