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

resource "aws_instance" "app_server" {
  ami                         = var.image_id
  instance_type               = var.instance_type
#  user_data                   = file("user_data.sh")
  subnet_id                   = "${aws_subnet.public_1a.id}"
  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
  key_name                    = var.key_name
#  associate_public_ip_address = true
#  public_dns                  = true

  tags = {
    Name                      = "app_server"
  }
}

resource "aws_instance" "app_server_2" {
  ami                         = var.image_id
  instance_type               = var.instance_type
#  user_data                   = file("user_data.sh")
  subnet_id                   = "${aws_subnet.public_1a.id}"
  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
  key_name                    = var.key_name
#  associate_public_ip_address = true
#  public_dns                  = true

  tags = {
    Name                      = "app_server"
  }
}

resource "aws_instance" "myadmin" {
  ami                         = var.image_id
  instance_type               = var.instance_type
#  user_data                   = file("bootstrap_for_back.sh")
  subnet_id                   = "${aws_subnet.public_1b.id}"
  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
  key_name                    = var.key_name
#  associate_public_ip_address = true
#  public_dns                  = true

  tags = {
    Name                      = "myadmin"
  }
}


#resource "aws_instance" "bastion" {
#  ami                         = var.image_id
#  instance_type               = var.instance_type
#  user_data                   = file("scripts_for_bastion.sh")
#  subnet_id                   = "${aws_subnet.public_1b.id}"
#  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
#  key_name                    = var.key_name
#  associate_public_ip_address = true
#
#  tags = {
#    Name                      = "bastion"
#  }
#}

output "load_balancer_name" {
  value = aws_lb.alb.dns_name
}
