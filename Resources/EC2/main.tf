resource "aws_security_group" "this_student_sg" {
  name        = var.sg_name
  description = "Security group for my StudentApp"
  vpc_id      = var.vpc_id  # replace with your VPC ID

  # Inbound rules
  ingress {
    description      = "Allow HTTP traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow HTTPS traffic"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow SSH access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  # Replace with specific IP for better security
  }

  ingress {
    description      = "Allow tomcat port access"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  # Replace with specific IP for better security
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


resource "aws_instance" "web" {
  ami           = var.this_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  #count                       = var.instance_count
  vpc_security_group_ids = [aws_security_group.this_student_sg.id]
  root_block_device {
    volume_size = var.this_aws_instance_volume_size
  }

  user_data = <<-EOF
              #!/bin/bash
              # Update the system
              apt-get update -y

              # Install Java (required for Tomcat)
              apt-get install -y openjdk-11-jdk

              # Install MySQL client
              apt-get install -y mariadb-client

              # Set JAVA_HOME
              echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> /etc/profile.d/java.sh
              source /etc/profile.d/java.sh

              # Download and install Tomcat 9.0.97
              wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.97/bin/apache-tomcat-9.0.97.tar.gz
              tar xzvf apache-tomcat-9.0.97.tar.gz -C /opt

              # Create a symbolic link to make Tomcat accessible
              ln -s /opt/apache-tomcat-9.0.97 /opt/tomcat

              # Set permissions
              chown -R root:root /opt/tomcat

              # Clone the Git repository that contains the student.war file
              git clone https://github.com/Swapnilbarsagade/AWS.git /tmp/aws

              # Copy the student.war file to the Tomcat webapps directory and mysql-connector.jar to lib directory
              cp /tmp/aws/tomcat9sstudent/student.war /opt/tomcat/webapps/
              cp /tmp/aws/tomcat9sstudent/mysql-connector.jar /opt/tomcat/lib/

               # Configure the database connection
              cat <<EOL > /opt/tomcat/conf/context.xml
              <Context>
                  <Resource name="jdbc/TestDB" auth="Container" type="javax.sql.DataSource"
                            maxTotal="100" maxIdle="30" maxWaitMillis="10000"
                            username="${db_username}" password="${db_password}" driverClassName="com.mysql.jdbc.Driver"
                            url="jdbc:mysql://${rds_endpoint}/${db_name}"/>
              </Context>
              EOL

              # Start Tomcat using catalina.sh
              /opt/tomcat/bin/catalina.sh stop
              /opt/tomcat/bin/catalina.sh start

              EOF

  tags = {
    Name = "StudentApp"
  }
}
