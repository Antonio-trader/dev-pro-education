terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}



provider "aws" {
  region          = var.region
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