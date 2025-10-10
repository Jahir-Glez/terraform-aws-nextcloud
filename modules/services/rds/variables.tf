variable "identifier" {
  description = "RDS instance identifier"
  type        = string
  default = "nextcloud-db"
}

variable "engine_db"{
  description = "Database engine"
  type = string
  default = "mariadb"
} 

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "10.6.23"
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Master username"
  type        = string
}

variable "db_password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 3306
}

variable "publicly_accessible" {
  description = "Whether the DB should be publicly accessible"
  type        = bool
  default     = false
}

variable "security_group_ids" {
  description = "List of VPC security group IDs to associate"
  type        = string
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Whether to skip final snapshot on destroy"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the RDS instance"
  type        = map(string)
  default     = {}
}
