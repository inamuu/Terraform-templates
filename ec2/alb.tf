resource "aws_lb" "web" {
  name                       = "web"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = ["aws_security_group.web.id"]
  subnets                    = [
    aws_subnet.staging-public-1a.id,
    aws_subnet.staging-public-1c.id
  ]
  enable_deletion_protection = true

  tags = {
    Name = "${terraform.workspace}-${var.service_name}-web"
  }
}

resource "aws_lb_target_group" "web" {
  name                 = "web"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = aws_vpc.main.id
  target_type          = "ip"
  deregistration_delay = "10"

  health_check {
    protocol            = "HTTP"
    path                = "/ping"
    port                = 80
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = 200
  }
}

resource "aws_alb_listener" "web-http" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "web-https" {
  load_balancer_arn = aws_lb.web.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = aws_acm_certificate.main.arn

  default_action {
    target_group_arn = aws_lb_target_group.web.arn
    type             = "forward"
  }
}

