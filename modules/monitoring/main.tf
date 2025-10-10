module "sns_alerts"{
    source = "../services/sns"
    topic_name = var.topic_name
    alert_email = var.alert_email
}
module "cloudwatch_alert"{
    source = "../services/cloudwatch"
    region = var.region
    secret_arn = var.secret_arn
    sns_topic_arn = module.sns_alerts.sns_topic_arn
    cloudtrail_s3_bucket = module.s3.cloudtrail_s3_bucket ### <----check it out later
    cloudtrail_role_arn = module.iam.cloudtrail_role_arn
    log_retention_days = var.log_retention_days
    tags = var.tags
}
module "iam"{
    source = "./iam"
    cloudtrail_log_group_name = module.cloudwatch_alert.cloudtrail_log_group_name
    cloudtrail_bucket_arn = module.s3.cloudtrail_bucket_arn
    region = var.region
    tags = var.tags
}
module "s3"{
    source = "./s3"
    cloudtrail_s3_bucket_name = var.cloudtrail_s3_bucket_name
    log_s3_expiration_days = var.log_s3_expiration_days
}

