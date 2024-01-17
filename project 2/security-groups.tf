resource "aws_security_group" "allow_tls" {
  name        = "bastion-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.dev-vpc.id

  # from port 443
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  # from port 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  # from port 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "bastion-allow_web_traffic"
  }
}

resource "aws_security_group" "app-server-sg" {
  name        = "app-server-sg"
  description = "Allow inbound traffic from bastion server"
  vpc_id      = aws_vpc.dev-vpc.id

  # from port 22
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.allow_tls.id]
    cidr_blocks     = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }


  tags = {
    Name = "app-server-traffic"
  }
}

#for the load balancer
resource "aws_security_group" "lb_sg" {
  name        = "load-balancer-sg"
  description = "load-balancer-sg"
  vpc_id      = aws_vpc.dev-vpc.id

   # from port 80
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }


  tags = {
    Name = "app-load-bal-sg"
  }
}

/*
resource "aws_security_group_rule" "app-server-sg" {
  security_group_id        = aws_security_group.allow_tls.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.allow_tls.id  # this is not so important to be included.
}

*/

