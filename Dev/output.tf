output "route53_domain_name" {
  value = module.route53.domain_name
  description = "The domain name retrieved from the Route53 module"
}