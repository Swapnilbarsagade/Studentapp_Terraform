# Security Group
variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instance will be launched"
  type        = string
}

variable "sg_name" {
  description = "Name for the security group"
  type        = string
  default     = "db-security-group"
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