resource "aws_lb_target_group" "alb-group" {
  name        = "tf-example-lb-alb-tg"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = aws_vpc.dev-vpc.id

  health_check {
    path = "/health"
  }
}


resource "aws_lb_listener" "connect" {
  count = 2
  load_balancer_arn = aws_lb.test[count.index].arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-group.arn
  }
}

#attachemnt of the instances to the target group 
resource "aws_lb_target_group_attachment" "app_server_attachment_1" {
  target_group_arn = aws_lb_target_group.alb-group.arn
  target_id        = aws_instance.app-server-1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "app_server_attachment_2" {
  target_group_arn = aws_lb_target_group.alb-group.arn
  target_id        = aws_instance.app-server-2.id
  port             = 80
}
