resource "aws_efs_file_system" "nextcloud_efs" {
  creation_token = "nextcloud-efs-token"
  encrypted      = true
  tags           = var.tags
}

resource "aws_efs_mount_target" "efs_mount_target_a" {
  file_system_id  = aws_efs_file_system.nextcloud_efs.id
  subnet_id       = aws_subnet.private_subnet_ecs.id
  security_groups = [aws_security_group.efs_sg.id]
}


