resource "aws_lb" "example" {
  name                       = "example"
  internal                   = false
  load_balancer_type         = "network"
  subnets                    = [aws_subnet.example-public-1a.id, aws_subnet.example-public-1c.id]
  enable_deletion_protection = true

  tags = {
    Env = "staging"
  }
}

resource "aws_lb_target_group" "example" {
  name                 = "example"
  port                 = 8080
  protocol             = "TCP"
  vpc_id               = aws_vpc.example.id
  target_type          = "ip"
  deregistration_delay = "10"

  health_check {
    interval            = 30
    port                = "traffic-port"
    protocol            = "TCP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

}

resource "aws_lb_listener" "example-https" {
  load_balancer_arn = aws_lb.example.arn
  port              = "443"
  protocol          = "TLS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.example.arn

  default_action {
    target_group_arn = aws_lb_target_group.example.arn
    type             = "forward"
  }
}

