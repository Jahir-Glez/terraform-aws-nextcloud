variable "creation_token" {
  description = "Unique token to ensure creation of EFS filesystem"
  type        = string
  default = "my-token-efs"
}

variable "encrypted" {
  description = "Whether to enable encryption for the EFS"
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "List of subnet IDs to create mount targets in"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the mount targets"
  type        = string
}

variable "tags" {
  description = "Tags to apply to EFS resources"
  type        = map(string)
  default     = {}
}
