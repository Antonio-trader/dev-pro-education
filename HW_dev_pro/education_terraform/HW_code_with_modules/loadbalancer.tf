resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ssh-http-allowed.id]
  subnets            = [aws_subnet.public_1a.id, aws_subnet.public_1b.id]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "appserver" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.application.arn
  }
}

resource "aws_lb_listener_rule" "phpmyadmin" {
  listener_arn = aws_lb_listener.appserver.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.myadmin.arn
  }
  condition {
    path_pattern {
      values = ["/phpMyAdmin/*"]
    }
  }
}


# app_web_server target group
resource "aws_lb_target_group" "application" {
  name        = "nginx"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc_for_dev_pro.id
}

#resource "aws_lb_target_group_attachment" "nginx1" {
#  target_group_arn = aws_lb_target_group.application.arn
#  target_id        = module.ec2_instance
#  port             = 80
#}

resource "aws_lb_target_group_attachment" "nginx2" {
  for_each         = toset(["app_server", "app_server_2"])
  target_group_arn = aws_lb_target_group.application.arn
  target_id        = module.ec2_instance[each.key].app_server.id
  port             = 80
  depends_on = [module.ec2_instance]
}


# myadmin target group
resource "aws_lb_target_group" "myadmin" {
  name        = "myadmin"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc_for_dev_pro.id
}

resource "aws_lb_target_group_attachment" "myadmin" {
  target_group_arn = aws_lb_target_group.myadmin.arn
  target_id        = aws_instance.myadmin.id
  port             = 80
}