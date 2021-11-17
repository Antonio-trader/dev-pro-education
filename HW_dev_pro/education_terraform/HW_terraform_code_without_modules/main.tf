provider "aws" {
  region          = var.region
}

resource "aws_instance" "app_server" {
  ami                         = var.image_id
  instance_type               = var.instance_type
#  user_data                   = file("user_data.sh")
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
#  user_data                   = file("user_data.sh")
  subnet_id                   = "${aws_subnet.public_1a.id}"
  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
  key_name                    = var.key_name
  associate_public_ip_address = true

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
  associate_public_ip_address = true

  tags = {
    Name                      = "myadmin"
  }
}


resource "aws_instance" "bastion" {
  ami                         = var.image_id
  instance_type               = var.instance_type
#  user_data                   = file("bootstrap_for_back.sh")
  subnet_id                   = "${aws_subnet.public_1b.id}"
  vpc_security_group_ids      = ["${aws_security_group.ssh-http-allowed.id}"]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name                      = "bastion"
  }
}

output "load_balancer_name" {
  value = aws_lb.alb.dns_name
}