output "ec2_instance_id" {
  value       = aws_instance.web.id
  description = "The ID of the EC2 instance"
}

output "ec2_instance_public_ip" {
  value       = aws_instance.web.public_ip
  description = "The public IP address of the EC2 instance"
}

output "security_group_id" {
  value       = aws_security_group.this_student_sg.id
  description = "The ID of the security group for the EC2 instance"
}