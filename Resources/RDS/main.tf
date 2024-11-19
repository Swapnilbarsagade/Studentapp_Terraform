# RDS database connection    ------------------>

# Security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = var.sg_name
  description = "Security group for the RDS instance"
  vpc_id      = var.vpc_id

  # Inbound rules to allow connections from the web server
  ingress {
    description      = "Allow MySQL/MariaDB traffic from web server"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.this_student_sg.id]
  }

  # Outbound rules
  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}


# RDS MariaDB instance
resource "aws_db_instance" "mariadb" {
  allocated_storage    = 20
  engine               = "mariadb"
  engine_version       = "10.6"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  db_name  = var.db_name
  publicly_accessible  = false
  subnet_id            = var.subnet_id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name # Replace with your DB subnet group name
  skip_final_snapshot  = true

  tags = {
    Name = "StudentAppDB"
  }
}
