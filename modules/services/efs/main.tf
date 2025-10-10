resource "aws_efs_file_system" "nextcloud_efs" {
  creation_token = var.creation_token
  encrypted      = var.encrypted
  tags           = var.tags
}

resource "aws_efs_mount_target" "efs_mount_target" {
  #count           = length(var.subnet_ids) ### To create mount targets in different Subnets
  file_system_id  = aws_efs_file_system.nextcloud_efs.id
  subnet_id       = var.subnet_ids
  security_groups = [var.security_group_ids]
}
