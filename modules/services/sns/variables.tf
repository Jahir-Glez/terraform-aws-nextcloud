variable "topic_name" {
  description = "Name of the SNS topic"
  type        = string
  default     = "secrets-manager-notifications"
}

variable "alert_email" {
  description = "Email address to receive SNS alerts"
  type        = string
}
