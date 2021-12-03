terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
  required_version = ">= 0.14.9"
}


provider "aws" {
  region          = var.region
}

provider "cloudflare" {
  email           = var.email
  api_key         = var.cloudflare_api_key
}

##############################
#   GREEN   #
##############################

resource "aws_instance" "app_server_green" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  subnet_id                   = "${aws_subnet.public_1a.id}"
  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
  key_name                    = var.key_name

  tags = {
    Name                      = "app_server"
  }
}

resource "aws_instance" "app_server_2_green" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  subnet_id                   = "${aws_subnet.public_1a.id}"
  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
  key_name                    = var.key_name

  tags = {
    Name                      = "app_server"
  }
}

resource "aws_instance" "myadmin_green" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  subnet_id                   = "${aws_subnet.public_1b.id}"
  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
  key_name                    = var.key_name

  tags = {
    Name                      = "myadmin"
  }
}


##############################
#   BLUE   #
##############################

resource "aws_instance" "app_server_blue" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  subnet_id                   = "${aws_subnet.public_1a.id}"
  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
  key_name                    = var.key_name

  tags = {
    Name                      = "app_server"
  }
}

resource "aws_instance" "app_server_2_blue" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  subnet_id                   = "${aws_subnet.public_1a.id}"
  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
  key_name                    = var.key_name

  tags = {
    Name                      = "app_server"
  }
}

resource "aws_instance" "myadmin_blue" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  subnet_id                   = "${aws_subnet.public_1b.id}"
  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
  key_name                    = var.key_name

  tags = {
    Name                      = "myadmin"
  }
}

##############################
###########   DB   ###########
##############################

resource "aws_instance" "db" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  subnet_id                   = "${aws_subnet.public_1b.id}"
  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
  key_name                    = var.key_name

  tags = {
    Name                      = "db"
  }
}

output "load_balancer_name_blue" {
  value = aws_lb.albBlue.dns_name
}

output "load_balancer_name_green" {
  value = aws_lb.albGreen.dns_name
}