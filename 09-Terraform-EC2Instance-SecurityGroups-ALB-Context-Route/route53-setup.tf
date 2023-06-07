data "aws_route53_zone" "domain" {
    name = var.domain_name
    private_zone = false
}

resource "aws_route53_record" "dns_record" {
  allow_overwrite = true
  name = tolist(aws_acm_certificate.test.domain_validation_options)[0].resource_record_name
  records = [tolist(aws_acm_certificate.test.domain_validation_options)[0].resource_record_value]
  type = tolist(aws_acm_certificate.test.domain_validation_options)[0].resource_record_type
  zone_id = data.aws_route53_zone.domain.zone_id
  ttl = 60
}

resource "aws_route53_record" "alb" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name = join(".",[var.sub_domain,data.aws_route53_zone.domain.name])
  type = "A"

  alias {
    name = aws_lb.app_loadbalance.dns_name
    zone_id = aws_lb.app_loadbalance.zone_id
    evaluate_target_health  = true
  }
}