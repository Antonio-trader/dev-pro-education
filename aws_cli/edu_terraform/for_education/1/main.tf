#variable "image_id" {
#  type            = string
#  description     = "The id of the machine image (AMI) to use for the server."
#  default         = "ami-047e03b8591f2d48a"
#}

provider "aws" {
  region          = var.region
}

#resource "aws_vpc" "vpc_for_dev_pro" {
#  cidr_block = var.cidr_block_for_vpc
#  tags = {
#    Name = "vpc_for_dev_pro"
#  }
#}
#
#resource "aws_subnet" "dev_pro_public" {
#  cidr_block        = var.cidr_block_for_public_subnet
#  vpc_id            = aws_vpc.vpc_for_dev_pro.id
#  availability_zone = var.region_for_subnet
#  tags = {
#    Name            = "dev_pro_public"
#  }
#}


#resource "aws_alb" "new_alb_for_dev_pro" {
#  name = var.name_for_alb
#  internal = false
#  idle_timeout = "300"
#  security_groups = [aws_security_group.ssh-http-allowed.id]
#  subnets = aws_subnet.dev_pro_public.id
#
#  tags = {
#    Name = "${var.name_for_alb}"
#  }
#}
#
#resource "aws_alb_listener" "listener_for_dev_pro" {
#  load_balancer_arn = "${aws_alb.new_alb_for_dev_pro.arn}"
#  port = 80
#  protocol = "HTTP"
#
#  default_action {
#    target_group_arn = "${aw}"
#    type = "forward"
#  }
#}


#
#resource "aws_security_group" "ssh-http-allowed" {
#  vpc_id = aws_vpc.vpc_for_dev_pro.id
#  egress {
#    from_port   = 0
#    protocol    = -1
#    to_port     = 0
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  ingress {
#    from_port   = 22
#    protocol    = "tcp"
#    to_port     = 22
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  ingress {
#    from_port   = 80
#    protocol    = "tcp"
#    to_port     = 80
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}

resource "aws_instance" "app_server" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  user_data                   = file("user_data.sh")
  subnet_id                   = "${aws_subnet.public_1a.id}"
  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name                      = "app_server"
  }
}

resource "aws_instance" "app_server_2" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  user_data                   = file("user_data.sh")
  subnet_id                   = "${aws_subnet.public_1a.id}"
  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name                      = "app_server_2"
  }
}

resource "aws_instance" "myadmin" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  user_data                   = file("bootstrap_for_back.sh")
  subnet_id                   = "${aws_subnet.public_1b.id}"
  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name                      = "myadmin"
  }
}

output "load_balancer_name" {
  value = aws_lb.alb.dns_name
}