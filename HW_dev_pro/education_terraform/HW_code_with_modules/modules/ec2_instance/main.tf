resource "aws_instance" "examplevm" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name
  user_data              = var.user_data
  name                   = var.name

  tags = {
    Name = var.name
  }
}

output "ec2" {
  value = aws_instance.examplevm.id
}