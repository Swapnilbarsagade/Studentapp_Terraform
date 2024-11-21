variable "domain_name" {
  description = "The domain name registered in Route 53"
  type        = string
  default     = "swapnilbdevops.online"
}

variable "subdomain" {
  description = "Subdomain for the carvcilla app"
  type        = string
  default     = "student.swapnilbdevops.online"  # Example subdomain (e.g., 'todo.example.com')
}