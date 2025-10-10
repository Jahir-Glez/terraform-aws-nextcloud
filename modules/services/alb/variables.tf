####ALB------------------------------------------------------------
variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}
variable "alb_subnets" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}
variable "alb_security_groups" {
  description = "List of Security Group IDs for the ALB"
  type        = string
}
variable "target_group_name" {
  description = "Name of the Target Group"
  type        = string
}
variable "target_group_port" {
  description = "Port used by the Target Group"
  type        = number
  default     = 80
}
variable "vpc_id" {
  description = "ID of the VPC where the Target Group is created"
  type        = string
}
variable "certificate_arn" {
  description = "ARN of the SSL certificate for HTTPS"
  type        = string
}
variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
