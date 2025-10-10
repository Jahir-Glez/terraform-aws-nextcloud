output "alb_dns_name" {
  value       = module.nextcloud_infrastructure.alb_dns_name
  description = "The DNS name of the Application Load Balancer"
}
