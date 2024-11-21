# Output for the Route 53 domain
output "route53_domain" {
  description = "DNS record created in Route 53"
  value       = aws_route53_record.student_dns_record.fqdn
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.boxer_certificate.arn
}

output "domain_name" {
  value = aws_route53_zone.selected_zone.name
  description = "The domain name managed by Route53"
}