resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
  tags = var.tags
}

### Task definition

resource "aws_ecs_task_definition" "nextcloud_task" {
  family                   = "nextcloud"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  cpu                      = "512"
  memory                   = "1024"
  tags                     = var.tags
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.nextcloud_image
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      secrets = [
        {
          name      = "MYSQL_PASSWORD"
          valueFrom = aws_secretsmanager_secret.db_secret.arn
        }
      ]
      environment = [
        {
          name  = "MYSQL_HOST"
          value = aws_db_instance.nextcloud_db.address
        },
        {
          name  = "MYSQL_DATABASE"
          value = var.db_name 
        },
        {
          name  = "MYSQL_USER"
          value = var.db_username 
        },
        ######S3
        {
          name  = "OBJECTSTORE_S3_BUCKET"
          value = var.s3_bucket_name
        },
        {
          name  = "OBJECTSTORE_S3_REGION"
          value = var.region
        },
        {
          name  = "OBJECTSTORE_S3_HOST"
          value = "s3.amazonaws.com"
        },
        {
          name  = "OBJECTSTORE_S3_AUTOCREATE"
          value = "false"
        }
      ]
      mountPoints = [
        {
          sourceVolume  = "nextcloud_data"
          containerPath = "/var/www/html/data"
          readOnly      = false
        },
        {
          sourceVolume  = "nextcloud_config"
          containerPath = "/var/www/html/config"
          readOnly      = false
        }
      ]

  }])
  volume {
    name = "nextcloud_data"
    host_path = "/mnt/efs/data"
  }
  volume {
    name = "nextcloud_config"
    host_path = "/mnt/efs/config"
  }
}

resource "aws_ecs_service" "nextcloud_service" {
  name            = "nextcloud_service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.nextcloud_task.arn
  desired_count   = 1
  launch_type     = "EC2"
  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_tg.arn
    container_name   = var.container_name
    container_port   = 80
  }
  health_check_grace_period_seconds = 300
  depends_on                        = [aws_lb_listener.alb_listener]
  tags                              = var.tags
}
