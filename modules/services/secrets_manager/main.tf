### This file manages the creation of a random password for DB and stores it in AWS Secrets Manager
resource "random_password" "db_password" {
  length  = var.password_length
  special = var.include_special_characters
}

resource "aws_secretsmanager_secret" "db_secret" {
  name        = var.secret_name
  description = var.secret_description
  tags        = var.tags

  # depends_on = [
  #   var.cloudtrail_dependency_enabled ? aws_cloudtrail.secrets_manager_trail : null
  # ]
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = random_password.db_password.result
}