# Security Group
variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}

variable "sg_name" {
  description = "Name for the security group"
  type        = string
  default     = "db-security-group"
}

variable "allowed_ssh_cidrs" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

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