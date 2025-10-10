resource "aws_db_instance" "nextcloud_db" {
  identifier             = var.identifier
  engine                 = var.engine_db
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  port                   = var.db_port
  publicly_accessible    = var.publicly_accessible
  vpc_security_group_ids = [var.security_group_ids]
  db_subnet_group_name   = var.db_subnet_group_name
  skip_final_snapshot    = var.skip_final_snapshot

  tags = var.tags
}
