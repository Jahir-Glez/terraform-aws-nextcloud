output "alb_sg_id" {
  value       = aws_security_group.alb_sg.id
  description = "ID of the ALB security group"
}

output "ecs_sg_id" {
  value       = aws_security_group.ecs_sg.id
  description = "ID of the ECS security group"
}

output "rds_sg_id" {
  value       = aws_security_group.rds_sg.id
  description = "ID of the RDS security group"
}

output "efs_sg_id" {
  value       = aws_security_group.efs_sg.id
  description = "ID of the EFS security group"
}

output "vpc_endpoints_sg_id" {
  value       = aws_security_group.vpc_endpoints_sg.id
  description = "ID of the VPC Endpoints security group"
}
