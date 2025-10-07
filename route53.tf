data "aws_route53_zone" "hosted_zone" {
  name         = "cloudbyjahir.xyz."
  private_zone = false
}


resource "aws_route53_record" "nextcloud_record" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "next.cloudbyjahir.xyz"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}


resource "aws_acm_certificate" "cert" {
  domain_name       = "cloudbyjahir.xyz"
  validation_method = "DNS"
  tags              = var.tags
  subject_alternative_names = [
    "*.cloudbyjahir.xyz"
    ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
    for_each = {for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => dvo}
    name   = each.value.resource_record_name
    type   = each.value.resource_record_type
    records = [each.value.resource_record_value]
    ttl    = 60
    zone_id = data.aws_route53_zone.hosted_zone.zone_id
    allow_overwrite = true   
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [
    for record in aws_route53_record.cert_validation : 
    record.fqdn
    ]
}
