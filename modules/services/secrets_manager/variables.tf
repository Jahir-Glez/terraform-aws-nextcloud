variable "secret_name" {
  description = "Name of the secret"
  type        = string
  default     = "db_credentials_v2"
}

variable "secret_description" {
  description = "Description for the secret"
  type        = string
  default     = "Auto-generated DB password"
}

variable "password_length" {
  description = "Length of the random password"
  type        = number
  default     = 20
}

variable "include_special_characters" {
  description = "Whether to include special characters in the password"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}

