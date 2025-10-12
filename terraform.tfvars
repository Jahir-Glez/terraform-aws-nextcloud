###Secrets module

db_secret_name = "dbsecret-v3"

# Monitoring module
topic_name                = "nextcloud-alerts"
alert_email               = "jahir@test.com" #<--- email
log_retention_days        = 7
log_s3_expiration_days    = 30

# Shared
region = "us-east-1"
tags = {
  environment = "dev"
  project     = "nextcloud"
  owner = "Jahir"
  name = "nextcloud_test" 
}

# ALB
alb_name          = "nextcloud-alb"
target_group_name = "nextcloud-tg"
target_group_port = 80

# ECS/ASG
ecs_ssm_path     = "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended/image_id"
instance_type    = "t3.small"
desired_capacity = 1
max_size         = 2
min_size         = 1

ecs_cluster_name = "nextcloud-cluster"
#task_cpu         = 512
##task_memory      = 1024

nextcloud_image  = "nextcloud:27-apache"
container_cpu    = 256
container_memory = 512
container_port   = 80

# DB
db_name     = "nextclouddb"
db_username = "admin"
##db_password = "your-db-password" ##maneged by secrets_manager
#db_port     = 3306

# S3
s3_bucket_name = "jahir-nextcloud-2025-10-1"

# RDS
instance_class     = "db.t3.micro"
allocated_storage  = 20

# Route 53 / DNS
zone_name      = "website.com."  #<<<----  Change zone name (it finish with a dot)
subdomain_fqdn = "nextcloud.website.com"#<<<--- change subdomain
domain_name    = "nextcloud.website.com"# <<--- Change domain_name

# Networking
vpc_cidr                 = "10.0.0.0/16"
public_subnet_a_cidr     = "10.0.1.0/24"
public_subnet_b_cidr     = "10.0.2.0/24"
private_subnet_ecs_cidr  = "10.0.3.0/24"
private_subnet_db_a_cidr = "10.0.4.0/24"
private_subnet_db_b_cidr = "10.0.5.0/24"
