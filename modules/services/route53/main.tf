data "aws_route53_zone" "hosted_zone" {
  name         = var.zone_name
  private_zone = false
}

# DNS record pointing to ALB
resource "aws_route53_record" "nextcloud_record" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = var.subdomain_fqdn
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

# Request wildcard ACM certificate
resource "aws_acm_certificate" "cert" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = ["*.${var.domain_name}"]
  tags                      = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

# Create validation records
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => dvo
  }

  name            = each.value.resource_record_name
  type            = each.value.resource_record_type
  records         = [each.value.resource_record_value]
  ttl             = 60
  zone_id         = data.aws_route53_zone.hosted_zone.zone_id
  allow_overwrite = true
}

# Validate the certificate
resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
