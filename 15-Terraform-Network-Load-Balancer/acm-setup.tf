resource "aws_acm_certificate" "test" {
  domain_name       = join(".", [var.site, data.aws_route53_zone.domain.name])
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.test.arn
  validation_record_fqdns = [aws_route53_record.dns_record.fqdn]
}