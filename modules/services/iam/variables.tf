##ECS task role to access to secrets
variable "secretsmanager_secret_arn" {
  description = "ARN of the Secrets Manager secret"
  type        = string
}
variable "region" {
  description = "AWS region"
  type        = string
}
variable "tags" {
  description = "Tags to apply to all IAM resources"
  type        = map(string)
  default     = {}
}