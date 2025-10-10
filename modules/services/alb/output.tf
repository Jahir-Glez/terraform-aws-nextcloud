output "alb_arn" {
  description = "ARN del Load Balancer"
  value       = aws_lb.alb.arn
}
output "alb_dns_name" {
  description = "DNS del Load Balancer"
  value       = aws_lb.alb.dns_name
}
output "alb_zone_id" {
  description = "Zone ID of the ALB"
  value       = aws_lb.alb.zone_id
}
output "target_group_arn" {
  description = "ARN del Target Group"
  value       = aws_lb_target_group.ecs_tg.arn
}
output "alb_listener" {
  description = "ALB listener resource for ECS to depend on"
  value = aws_lb.alb
}