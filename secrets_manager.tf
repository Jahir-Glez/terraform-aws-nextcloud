### This file manages the creation of a random password for DB and stores it in AWS Secrets Manager
resource "random_password" "db_password" {
  length           = 20
  special          = true 
}

resource "aws_secretsmanager_secret" "db_secret" {
    name = "db_credentials"
    description = "Auto-generated DB password"
    tags = var.tags
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
    secret_id     = aws_secretsmanager_secret.db_secret.id   
    secret_string = random_password.db_password.result
}

