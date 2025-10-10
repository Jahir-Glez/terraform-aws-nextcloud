variable "zone_name" {
  description = "The Route53 hosted zone name (must end with a dot)"
  type        = string
}

variable "subdomain_fqdn" {
  description = "Fully-qualified domain name for the subdomain (e.g. next.domain.com)"
  type        = string
}

variable "domain_name" {
  description = "The main domain name (e.g. domain.com)"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "Zone ID of the ALB"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
