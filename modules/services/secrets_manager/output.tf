output "secret_arn" {
  description = "ARN of the created secret"
  value       = aws_secretsmanager_secret.db_secret.arn
}

output "secret_name" {
  description = "Name of the created secret"
  value       = aws_secretsmanager_secret.db_secret.name
}

output "secret_value" {
  description = "The randomly generated password"
  value       = random_password.db_password.result
  sensitive   = true
}
