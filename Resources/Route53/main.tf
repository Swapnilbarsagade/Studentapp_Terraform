# Route 53 Hosted Zone (if you don’t already have it)
data "aws_route53_zone" "selected_zone" {
  name         = var.domain_name
  private_zone = false
}



# ACM Certificate for the Domain
resource "aws_acm_certificate" "boxer_certificate" {
  domain_name       = "${var.subdomain}.${var.domain_name}"
  validation_method = "DNS"

  tags = {
    Name = "boxer-certificate"
  }
}

# Route 53 DNS Validation Record for ACM
resource "aws_route53_record" "acm_validation_record" {
  for_each = { for d in aws_acm_certificate.boxer_certificate.domain_validation_options : d.domain_name => d }
  name     = each.value.resource_record_name
  type     = each.value.resource_record_type
  zone_id  = data.aws_route53_zone.selected_zone.zone_id
  records  = [each.value.resource_record_value]
  ttl      = 300
}

# Validate the ACM Certificate
resource "aws_acm_certificate_validation" "boxer_certificate_validation" {
  certificate_arn         = aws_acm_certificate.boxer_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation_record : record.fqdn]
}



# Update the Route 53 Record to Support HTTPS
resource "aws_route53_record" "student_dns_record" {
  zone_id = data.aws_route53_zone.selected_zone.zone_id
  name    = var.subdomain
  type    = "CNAME"
  ttl     = 300
  records = [var.alb_dns_name]
}
