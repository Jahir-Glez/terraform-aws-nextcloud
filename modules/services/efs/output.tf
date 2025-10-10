output "efs_id" {
  description = "ID of the EFS filesystem for ASG"
  value       = aws_efs_file_system.nextcloud_efs.id
}

output "efs_mount_target_ids" {
  description = "IDs of the EFS mount targets"
  value       = aws_efs_mount_target.efs_mount_target[*].id
}
