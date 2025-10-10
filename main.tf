module "secrets"{
    source = "./modules/services/secrets_manager"
    secret_name = var.db_secret_name
    tags = var.tags
}
module "monitoring" {
    source = "./modules/monitoring"
    topic_name = var.topic_name
    secret_arn = module.secrets.secret_arn
    alert_email = var.alert_email
    cloudtrail_s3_bucket_name = var.s3_bucket_name
    log_retention_days = var.log_retention_days
    log_s3_expiration_days = var.log_s3_expiration_days ##s3
    region = var.region
    tags = var.tags
}

module "nextcloud_infrastructure"{
    source = "./modules/nextcloud_infrastructure"
    secretsmanager_secret_arn = module.secrets.secret_arn
    region                    = var.region
    tags                      = var.tags

    alb_name           = var.alb_name
    target_group_name  = var.target_group_name
    target_group_port  = var.target_group_port

    ecs_ssm_path       = var.ecs_ssm_path
    instance_type      = var.instance_type
    desired_capacity   = var.desired_capacity
    max_size           = var.max_size
    min_size           = var.min_size

    ecs_cluster_name   = var.ecs_cluster_name
    ##task_cpu           = var.task_cpu
    ##task_memory        = var.task_memory
    nextcloud_image    = var.nextcloud_image
    container_cpu      = var.container_cpu
    container_memory   = var.container_memory
    container_port     = var.container_port

    db_name            = var.db_name
    db_username        = var.db_username
    db_password_secrets_manager = module.secrets.secret_value
    #db_port            = var.db_port

    s3_bucket_name     = var.s3_bucket_name

    instance_class     = var.instance_class
    allocated_storage  = var.allocated_storage

    zone_name          = var.zone_name
    subdomain_fqdn     = var.subdomain_fqdn
    domain_name        = var.domain_name

    vpc_cidr                 = var.vpc_cidr
    public_subnet_a_cidr     = var.public_subnet_a_cidr
    public_subnet_b_cidr     = var.public_subnet_b_cidr
    private_subnet_ecs_cidr  = var.private_subnet_ecs_cidr
    private_subnet_db_a_cidr = var.private_subnet_db_a_cidr
    private_subnet_db_b_cidr = var.private_subnet_db_b_cidr
}
