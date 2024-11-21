module "vpc" {
  source               = "/home/cloudshell-user/Studentapp_Terraform/Resources/VPC"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidr  = "10.0.2.0/24"
  availability_zone    = "ap-northeast-2a"
  vpc_name             = "main-vpc"
  igw_name             = "main-igw"
  public_subnet_name   = "public-subnet"
  private_subnet_name  = "private-subnet"
  public_rt_name       = "public-rt"
  private_rt_name      = "private-rt"
}

module "ec2" {
  source          = "/home/cloudshell-user/Studentapp_Terraform/Resources/EC2"
  vpc_id          = module.vpc.vpc_id
  subnet_ids       = [module.vpc.public_subnet_id]
  this_ami          = "ami-042e76978adeb8c48" # Replace with a valid AMI ID
  instance_type   = "t2.micro"
  key_name        = "batmobile"
  associate_public_ip_address = true
  this_aws_instance_volume_size  = 10
  instance_name   = "web-server"
  sg_name         = "web-server-sg"
  allowed_ssh_cidrs = ["203.0.113.0/24"] # Restrict to your IP range
  certificate_arn = module.route53.acm_certificate_arn
}

module "route53" {
  source          = "/home/cloudshell-user/Studentapp_Terraform/Resources/Route53"
  domain_name     = "swapnilbdevops.online"
  subdomain       = "student"
  alb_dns_name    = module.ec2.alb_dns_name   #aws_lb.student_alb.dns_name
}