resource "aws_lb" "albGreen" {
  name                        = "albGreen"
  internal                    = false
  load_balancer_type          = "application"
  security_groups             = [aws_security_group.ssh-http-allowed.id]
  subnets                     = [aws_subnet.public_1a.id, aws_subnet.public_1b.id]

  enable_deletion_protection  = false

  tags = {
    Name                      = "albGreen"
  }
}

resource "aws_lb_listener" "appserver_green" {
  load_balancer_arn           = aws_lb.albGreen.arn
  port                        = "80"
  protocol                    = "HTTP"

  default_action {
    type                      = "forward"
    target_group_arn          = aws_lb_target_group.application_green.arn
  }
}

resource "aws_lb_listener_rule" "phpmyadmin_green" {
  listener_arn                = aws_lb_listener.appserver_green.arn
  priority                    = 100

  action {
    type                      = "forward"
    target_group_arn          = aws_lb_target_group.myadmin_green.arn
  }
  condition {
    path_pattern {
      values                  = ["/phpMyAdmin/*"]
    }
  }
}


# app_web_server target group
resource "aws_lb_target_group" "application_green" {
  name                        = "nginxGreen"
  port                        = 80
  protocol                    = "HTTP"
  target_type                 = "instance"
  vpc_id                      = aws_vpc.vpc_for_dev_pro.id
}

resource "aws_lb_target_group_attachment" "nginx1_green" {
  target_group_arn            = aws_lb_target_group.application_green.arn
  target_id                   = aws_instance.app_server_2_green.id
  port                        = 80
}

resource "aws_lb_target_group_attachment" "nginx2_green" {
  target_group_arn            = aws_lb_target_group.application_green.arn
  target_id                   = aws_instance.app_server_2_green.id
  port                        = 80
}


# myadmin target group
resource "aws_lb_target_group" "myadmin_green" {
  name                        = "myadminGreen"
  port                        = 80
  protocol                    = "HTTP"
  target_type                 = "instance"
  vpc_id                      = aws_vpc.vpc_for_dev_pro.id
}

resource "aws_lb_target_group_attachment" "myadmin" {
  target_group_arn            = aws_lb_target_group.myadmin_green.arn
  target_id                   = aws_instance.myadmin_green.id
  port                        = 80
}


##################################################
#################   BLUE   #######################
##################################################

resource "aws_lb" "albBlue" {
  name                        = "albBlue"
  internal                    = false
  load_balancer_type          = "application"
  security_groups             = [aws_security_group.ssh-http-allowed.id]
  subnets                     = [aws_subnet.public_1a.id, aws_subnet.public_1b.id]

  enable_deletion_protection  = false

  tags = {
    Name                      = "albBlue"
  }
}


resource "aws_lb_listener" "appserver_blue" {
  load_balancer_arn           = aws_lb.albBlue.arn
  port                        = "80"
  protocol                    = "HTTP"

  default_action {
    type                      = "forward"
    target_group_arn          = aws_lb_target_group.application_blue.arn
  }
}

resource "aws_lb_listener_rule" "phpmyadmin_blue" {
  listener_arn                = aws_lb_listener.appserver_blue.arn
  priority                    = 100

  action {
    type                      = "forward"
    target_group_arn          = aws_lb_target_group.myadmin_blue.arn
  }
  condition {
    path_pattern {
      values                  = ["/phpMyAdmin/*"]
    }
  }
}

# app_web_server target group
resource "aws_lb_target_group" "application_blue" {
  name                        = "nginxBlue"
  port                        = 80
  protocol                    = "HTTP"
  target_type                 = "instance"
  vpc_id                      = aws_vpc.vpc_for_dev_pro.id
}

resource "aws_lb_target_group_attachment" "nginx1_blue" {
  target_group_arn            = aws_lb_target_group.application_blue.arn
  target_id                   = aws_instance.app_server_blue.id
  port                        = 80
}

resource "aws_lb_target_group_attachment" "nginx2_blue" {
  target_group_arn            = aws_lb_target_group.application_blue.arn
  target_id                   = aws_instance.app_server_2_blue.id
  port                        = 80
}

# myadmin target group
resource "aws_lb_target_group" "myadmin_blue" {
  name                        = "myadminBlue"
  port                        = 80
  protocol                    = "HTTP"
  target_type                 = "instance"
  vpc_id                      = aws_vpc.vpc_for_dev_pro.id
}

resource "aws_lb_target_group_attachment" "myadmin_blue_2" {
  target_group_arn            = aws_lb_target_group.myadmin_blue.arn
  target_id                   = aws_instance.myadmin_blue.id
  port                        = 80
}













