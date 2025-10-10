output "db_instance_endpoint" {
  description = "RDS instance endpoint address"
  value       = aws_db_instance.nextcloud_db.address
}

output "db_instance_id" {
  description = "RDS instance identifier"
  value       = aws_db_instance.nextcloud_db.id
}
