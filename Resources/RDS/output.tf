output "rds_endpoint" {
  description = "RDS endpoint for the MariaDB instance"
  value       = aws_db_instance.mariadb.endpoint
}