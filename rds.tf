resource "aws_db_instance" "nextcloud_db" {
  identifier = "nextcloud-db"
  engine = "mariadb"
  engine_version = "10.6.23"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  db_name = "nextcloud"
  username = "NEXTCLOUD_USER"
  password = "NEXTCLOUD_PASSWORD"
  port = 3306
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.nextcloud_db_subnet_group.name
  skip_final_snapshot = true
  tags = var.tags
}