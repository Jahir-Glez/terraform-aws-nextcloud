# Get ECS-optimized AMI from SSM
data "aws_ssm_parameter" "ecs_ami" {
  name = var.ecs_ssm_path
}

# Launch Template for ECS instances
resource "aws_launch_template" "ecs_lt" {
  name_prefix   = "ecs-lt-"
  image_id      = data.aws_ssm_parameter.ecs_ami.value
  instance_type = var.instance_type

  vpc_security_group_ids = [var.ecs_sg_id]

  iam_instance_profile {
    name = var.ecs_iam_instance_profile_name
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh.tmpl", {
    efs_name     = var.efs_name
    ecs_cluster_name = var.ecs_cluster_name
    region           = var.region
  }))
}

# Auto Scaling Group
resource "aws_autoscaling_group" "ecs_asg" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  health_check_type   = "EC2"
  vpc_zone_identifier = [var.private_subnets]
  target_group_arns   = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.ecs_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ECS Instance"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
