resource "aws_instance" "bastion" {
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
  key_name = "cloud-project"
  monitoring = true
  security_groups = [aws_security_group.allow_tls.id]
  subnet_id = aws_subnet.public-web-subnet[0].id
  tenancy = "default"
  associate_public_ip_address = true
  availability_zone = "us-east-1a"
  user_data = <<-EOF
                 #!/bin/bash
                 sudo apt update -y
                 sudo apt install apache2 -y
                 sudo systemctl start apache2
                 sudo bash -c 'echo your very first web server > /var/www/html/index.html'
                 EOF
  

  tags = {
    Name = "Bastion-server"
  }
}

resource "aws_instance" "app-server-1" {
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
  key_name = "cloud-project"
  monitoring = true
  security_groups = [aws_security_group.app-server-sg.id]
  #vpc_security_group_ids = [aws_security_group.allow_tls.id, aws_security_group.app-server-sg.id]
  subnet_id = aws_subnet.private-app-subnet[0].id
  tenancy = "default"
  associate_public_ip_address = false
  availability_zone = "us-east-1a"
  user_data = <<-EOF
                 #!/bin/bash
                 sudo yum update -y
                 sudo yum install -y httpd wget php-fpm php-mysqli php-json php php-devel
                 sudo yum install mariadb105-server
                 sudo systemctl start httpd
                 sudo systemctl enable httpd
                 sudo systemctl is-enabled httpd.service
                 sudo usermod -a -G apache ec2-user
                 sudo chown -R ec2-user:apache /var/www/html
                 sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
                 find /var/www -type f -exec sudo chmod 0664 {} \;
                 sudo yum install php-mbstring php-xml -y
                 sudo systemctl restart httpd
                 sudo systemctl restart php-fpm
                 cd /var/www/html
                 wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
                 mkdir phpMyAdmin && tar -xvzf phpMyAdmin-latest-all-languages.tar.gz -C phpMyAdmin --strip-components 1
                 rm phpMyAdmin-latest-all-languages.tar.gz

                 
                 EOF
  

  tags = {
    Name = "Application-server-1"
  }
}

resource "aws_instance" "app-server-2" {
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
  key_name = "cloud-project"
  monitoring = true
  security_groups = [aws_security_group.app-server-sg.id]
  #vpc_security_group_ids = [aws_security_group.allow_tls.id, aws_security_group.app-server-sg.id]
  subnet_id = aws_subnet.private-app-subnet[1].id
  tenancy = "default"
  associate_public_ip_address = false
  availability_zone = "us-east-1b"
  user_data = <<-EOF
                 #!/bin/bash
                 sudo yum update -y
                 sudo yum install -y httpd wget php-fpm php-mysqli php-json php php-devel
                 sudo yum install mariadb105-server
                 sudo systemctl start httpd
                 sudo systemctl enable httpd
                 sudo systemctl is-enabled httpd.service
                 sudo usermod -a -G apache ec2-user
                 sudo chown -R ec2-user:apache /var/www/html
                 sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
                 find /var/www -type f -exec sudo chmod 0664 {} \;
                 sudo yum install php-mbstring php-xml -y
                 sudo systemctl restart httpd
                 sudo systemctl restart php-fpm
                 cd /var/www/html
                 wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
                 mkdir phpMyAdmin && tar -xvzf phpMyAdmin-latest-all-languages.tar.gz -C phpMyAdmin --strip-components 1
                 rm phpMyAdmin-latest-all-languages.tar.gz


                 EOF
  

  tags = {
    Name = "Application-server-2"
  }
}