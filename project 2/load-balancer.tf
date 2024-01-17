resource "aws_lb" "test" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  count = 3
  subnets            = [aws_subnet.public-web-subnet[count.index].id]
  enable_cross_zone_load_balancing = true
  enable_http2 = true
  idle_timeout     = 400
  #[for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = false
/*
  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "test-lb"
    enabled = true
  }
*/
  tags = {
    Environment = "development"
  }
}