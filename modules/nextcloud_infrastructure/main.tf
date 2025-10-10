module "iam" {
    source = "../services/iam"
    secretsmanager_secret_arn = var.secretsmanager_secret_arn
    region = var.region
    tags = var.tags
}
module "alb" {
    source = "../services/alb"
    alb_name = var.alb_name
    alb_subnets = module.networking.public_subnets 
    alb_security_groups = module.sg.alb_sg_id
    target_group_name = var.target_group_name
    target_group_port = var.target_group_port
    vpc_id = module.vpc.vpc_id
    certificate_arn = module.route53.certificate_arn
    tags = var.tags

}
module "asg" {
    source = "../services/asg"
    ecs_ssm_path = var.ecs_ssm_path
    instance_type = var.instance_type
    ecs_sg_id = module.sg.ecs_sg_id
    ecs_iam_instance_profile_name = module.iam.ecs_instance_profile_name
    efs_name = module.efs.efs_id
    ecs_cluster_name = module.ecs.ecs_cluster_name
    region = var.region
    private_subnets = module.networking.private_subnet_ecs_id
    target_group_arn = module.alb.target_group_arn
    desired_capacity = var.desired_capacity
    max_size = var.max_size
    min_size = var.min_size
    tags = var.tags
}
module "ecs" {
    source = "../services/ecs"
    ecs_cluster_name = var.ecs_cluster_name
    #task_cpu = var.task_cpu
    #task_memory = var.task_memory
    nextcloud_image = var.nextcloud_image
    container_cpu = var.container_cpu
    container_memory = var.container_memory
    container_port = var.container_port
    db_secret_arn = var.secretsmanager_secret_arn
    db_host = module.rds.db_instance_endpoint
    db_name = var.db_name
    db_username = var.db_username
    s3_bucket_name = var.s3_bucket_name
    region = var.region
    target_group_arn = module.alb.target_group_arn
    execution_role_arn = module.iam.ecs_task_execution_role_arn
    lb_listener_dependencies = [module.alb.alb_listener]
    tags = var.tags
} 
module "efs" {
    source = "../services/efs"
    subnet_ids = module.networking.private_subnet_ecs_id
    security_group_ids = module.sg.efs_sg_id
    tags = var.tags
}
module "s3" {
    source = "../services/s3"
    s3_bucket_name = var.s3_bucket_name
    ecs_instance_role_arn = module.iam.ecs_instance_role_arn
    tags = var.tags
}
module "rds"{
    source = "../services/rds"
    instance_class = var.instance_class
    allocated_storage = var.allocated_storage
    db_name = var.db_name
    db_username = var.db_username
    db_password = var.db_password_secrets_manager
    #db_port = var.db_port
    security_group_ids = module.sg.rds_sg_id
    db_subnet_group_name = module.networking.db_subnet_group_name 

    tags = var.tags
    
}
module "networking"{
    source = "../services/networking"
    vpc_id = module.vpc.vpc_id
    region = var.region
    public_subnet_a_cidr = var.public_subnet_a_cidr
    public_subnet_b_cidr = var.public_subnet_b_cidr
    private_subnet_ecs_cidr = var.private_subnet_ecs_cidr
    private_subnet_db_a_cidr = var.private_subnet_db_a_cidr
    private_subnet_db_b_cidr = var.private_subnet_db_b_cidr
    tags = var.tags
}
module "route53"{
    source = "../services/route53"
    zone_name = var.zone_name
    subdomain_fqdn = var.subdomain_fqdn
    domain_name = var.domain_name
    alb_dns_name = module.alb.alb_dns_name
    alb_zone_id = module.alb.alb_zone_id
    tags = var.tags
}
module "sg"{
    source = "../services/sg"
    vpc_id = module.vpc.vpc_id
    tags = var.tags
}
module "vpc"{
    source = "../services/vpc"
    vpc_cidr = var.vpc_cidr
    public_subnet_a_id = module.networking.public_subnet_a_id
    public_subnet_b_id = module.networking.public_subnet_b_id
    private_subnet_ecs_id = module.networking.private_subnet_ecs_id
    region = var.region
    tags = var.tags
}