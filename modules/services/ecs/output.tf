output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.ecs_cluster.id
}
output "ecs_cluster_name" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.ecs_cluster.name
}


output "ecs_task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = aws_ecs_task_definition.nextcloud_task.arn
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.nextcloud_service.name
}
