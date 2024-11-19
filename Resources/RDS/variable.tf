# RDS variable--->

variable "db_username" {
  description = "The master username for the RDS instance"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The master password for the RDS instance"
  type        = string
  sensitive   = true  # Marked as sensitive to avoid output in logs
}

variable "db_name" {
  description = "The name of the initial database to create"
  type        = string
  default     = "mydb"
}