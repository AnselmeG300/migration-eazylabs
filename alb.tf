resource "aws_lb" "pwd_eazylabs_lb" {
  name               = "pwd-eazylabs-load-balancer"
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.pwd_eazylabs_alb_sg.id
  ]
  subnets = [
    data.aws_subnet.public_subnet.id,
    data.aws_subnet.public_subnet1.id
  ]

  idle_timeout = 1200
}


resource "aws_lb_target_group" "pwd_eazylabs_lb_tg" {
  name     = "pwd-eazylabs-lg-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.pwd_eazylabs.id

  stickiness {
    enabled = true
    type    = "lb_cookie"
  }

  health_check {
    interval            = 60
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = 401

  }

  target_type = "instance" # Cible les instances EC2 dans l'Auto Scaling Group
}


resource "aws_lb_listener" "pwd_eazylabs_front" {
  load_balancer_arn = aws_lb.pwd_eazylabs_lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.certficate_ssl1.arn

  default_action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.pwd_eazylabs_lb_tg.arn
        weight = 1
      }
    }
  }
}

resource "aws_lb_listener_certificate" "example" {
  listener_arn    = aws_lb_listener.pwd_eazylabs_front.arn
  certificate_arn = data.aws_acm_certificate.certficate_ssl2.arn
}


resource "aws_lb_listener" "redirect_http_to_https" {
  load_balancer_arn = aws_lb.pwd_eazylabs_lb.arn
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

