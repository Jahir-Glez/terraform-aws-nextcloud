resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
  tags = var.tags
}

resource "aws_ecs_task_definition" "nextcloud_task" {
  family                   = var.task_family
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  tags                     = var.tags

  execution_role_arn = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.nextcloud_image
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]

      secrets = [
        {
          name      = "MYSQL_PASSWORD"
          valueFrom = var.db_secret_arn
        }
      ]

      environment = [
        {
          name  = "MYSQL_HOST"
          value = var.db_host
        },
        {
          name  = "MYSQL_DATABASE"
          value = var.db_name
        },
        {
          name  = "MYSQL_USER"
          value = var.db_username
        },
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
    }
  ])

  volume {
    name      = "nextcloud_data"
    host_path = var.nextcloud_data_host_path
  }

  volume {
    name      = "nextcloud_config"
    host_path = var.nextcloud_config_host_path
  }
}

resource "aws_ecs_service" "nextcloud_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.nextcloud_task.arn
  desired_count   = var.desired_count
  launch_type     = "EC2"

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  depends_on = [var.lb_listener_dependencies]

  tags = var.tags
}
