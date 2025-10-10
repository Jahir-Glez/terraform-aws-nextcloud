#### LOG BUCKET CLOUDTRAIL
variable "cloudtrail_s3_bucket_name"{
  description = "Logs bucket name for cloudtrail"
  type = string
}

variable "log_s3_expiration_days" {
  description = "Number of days before logs expire in the log bucket"
  type        = number
  default     = 30
}
###GENERAL

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
