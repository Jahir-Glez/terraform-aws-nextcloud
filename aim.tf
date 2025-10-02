resource "aws_iam_role" "ecs_instance_role"{
    name = "ecsInstanceRole"
    assume_role_policy = jsonencode(var.role_policy)
    tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_policy_attachment" {
    role       = aws_iam_role.ecs_instance_role.name
    policy_arn = var.ecs_instance_role_policy
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
    name = "ecsInstanceProfile"
    role = aws_iam_role.ecs_instance_role.name
}