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