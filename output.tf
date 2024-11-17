# Output for the Application Load Balancer (ALB) DNS name
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.student_alb.dns_name
}

# Output for the Route 53 domain
output "route53_domain" {
  description = "DNS record created in Route 53"
  value       = aws_route53_record.student_dns_record.fqdn
}

# Outputs for RDS and web server
output "rds_endpoint" {
  description = "RDS endpoint for the MariaDB instance"
  value       = aws_db_instance.mariadb.endpoint
}

output "web_server_public_ip" {
  description = "Public IP address of the web server"
  value       = aws_instance.web.public_ip
}