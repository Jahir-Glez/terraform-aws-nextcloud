##Launch Template for Auto Scaling Group
data "aws_ssm_parameter" "ecs_ami" {
  name = var.ecs_ssm_path
}
resource "aws_launch_template" "ecs_lt" {
  name_prefix   = "ecs-lt-"
  image_id      = data.aws_ssm_parameter.ecs_ami.value
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.ecs_sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }
  user_data = base64encode(templatefile("./user_data.sh.tmpl", {
    efs_dns_name     = aws_efs_file_system.nextcloud_efs.id
    ecs_cluster_name = var.ecs_cluster_name
    region           = var.region
  }))
}

### Auto Scaling Group
resource "aws_autoscaling_group" "ecs_asg" {
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  health_check_type   = "EC2"
  vpc_zone_identifier = [aws_subnet.private_subnet_ecs.id]
  target_group_arns   = [aws_lb_target_group.ecs_tg.arn]

  launch_template {
    id      = aws_launch_template.ecs_lt.id
    version = "$Latest"
  }
}