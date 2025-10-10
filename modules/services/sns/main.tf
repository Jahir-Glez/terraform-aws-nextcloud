resource "aws_sns_topic" "secrets_manager_notifi" {
  name = var.topic_name
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.secrets_manager_notifi.arn
  protocol  = "email"
  endpoint  = var.alert_email
}
