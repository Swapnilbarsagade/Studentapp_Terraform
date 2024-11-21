
# Security Group
variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}

variable "sg_name" {
  description = "Name for the security group"
  type        = string
  default     = "student-security-group"
}

variable "allowed_ssh_cidrs" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# EC2 variables for studentapp: 

variable "instance_name" {
  description = "Type of the instance to launch"
  type        = string
  default     = "web-server"
}

variable "this_ami" {
  description = "Type of the instance to launch"
  type        = string
  default     = "ami-042e76978adeb8c48"
}

variable "instance_type" {
  description = "Type of the instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for the instance"
  type        = string
  default     = "batmobile"
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address"
  type        = bool
  default     = true
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "this_aws_instance_volume_size" {
  description = "this_aws_instance_volume_size for instance"
  type        = number
  default     =  10
}

variable "subnet_ids" {
  description = "The ID of the subnet where the EC2 instance will be launched"
  type        =  list(string)
}


# In ec2 module's variables.tf
variable "certificate_arn" {
  type = string
}