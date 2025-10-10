output "launch_template_id" {
  description = "ID of the ECS launch template"
  value       = aws_launch_template.ecs_lt.id
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.ecs_asg.name
}
