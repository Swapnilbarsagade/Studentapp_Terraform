output "rds_endpoint" {
  description = "RDS endpoint for the MariaDB instance"
  value       = aws_db_instance.mariadb.endpoint
}

output "db_name" {
  description = "Database name for the RDS instance"
  value       = aws_db_instance.mariadb.name
}

output "db_username" {
  description = "RDS database username"
  value       = var.db_username
}

output "db_password" {
  description = "RDS database password"
  value       = var.db_password
}
