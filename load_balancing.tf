resource "aws_lb_target_group" "target_group-2" {
  name     = "target-group-2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-2.id
  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 10
    unhealthy_threshold = 2
  }
}

resource "aws_lb" "load_balancer-2" {
  name               = "load_balancer-2"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.security_group-2.id]
  subnets = [aws_subnet.subnet-2-1.id, aws_subnet.subnet-2-2.id]  
  enable_deletion_protection = false
}

resource "aws_lb_listener" "lb_listener-2" {
  load_balancer_arn = aws_lb.load_balancer-2.arn
  port              = 80
  protocol          = "HTTP"
  
  default_action {
    target_group_arn = aws_lb_target_group.target_group-2.arn
    type             = "forward"
  }
}
