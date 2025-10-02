##Launch Template for Auto Scaling Group
data "aws_ssm_parameter" "ecs_ami" {
  name = var.ecs_ssm_path
}
resource "aws_launch_template" "ecs_lt" {
    name_prefix = "ecs-lt-"
    image_id = aws_ssm_parameter.ecs_ami.value
    instance_type = var.instance_type

    vpc_security_group_ids = [aws_security_group.ecs_sg.id]

    aws_iam_instance_profile {
        name = aws_iam_instance_profile.ecsInstanceProfile.name
    }
    user_data = var.user_data_ecs
}