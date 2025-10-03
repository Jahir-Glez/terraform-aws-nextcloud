resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
  tags = var.tags  
}

### Task definition

resource "aws_ecs_task_definition" "nextcloud_task"{
    family = "nextcloud"
    requires_compatibilities = ["EC2"]
    network_mode = "bridge"
    cpu = "512"
    memory = "1024"
    tags = var.tags

    container_definitions = jsonencode([
        {
            name = var.container_name
            image = var.nextcloud_image
            cpu = 512
            memory = 1024
            essential = true
            portMappings = [
                {
                    containerPort = 80
                    hostPort = 80
                    protocol = "tcp"
                }
            ]
            environment = [
                {
                    name = "MYSQL_HOST"
                    value = aws_db_instance.nextcloud_db.address
                },
                {
                    name = "MYSQL_DATABASE"
                    value = "nextcloud"   ######## MODIFY THIS####!!!!!!!!
                },
                {
                    name = "MYSQL_USER"
                    value = "NEXTCLOUD_USER"
                },
                {
                    name = "MYSQL_PASSWORD"
                    value = "NEXTCLOUD_PASSWORD"
                }
            ]
}])
}

resource "aws_ecs_service" "nextcloud_service" {
    name = "nextcloud_service"
    cluster = aws_ecs_cluster.ecs_cluster.id
    task_definition = aws_ecs_task_definition.nextcloud_task.arn
    desired_count = 1
    launch_type = "EC2"
    load_balancer {
        target_group_arn = aws_lb_target_group.ecs_tg.arn
        container_name = var.container_name
        container_port = 80
    }
    health_check_grace_period_seconds = 300
    depends_on = [aws_lb_listener.alb_listener]
    tags = var.tags
}
