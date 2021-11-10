
resource "aws_security_group" "ssh-http-allowed" {
  vpc_id              = aws_vpc.vpc_for_dev_pro.id
  egress {
    from_port         = 0
    protocol          = -1
    to_port           = 0
    cidr_blocks       = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    protocol  = "icmp"
    to_port   = -1
    cidr_blocks       = ["0.0.0.0/0"]
  }

  ingress {
    from_port         = 22
    protocol          = "tcp"
    to_port           = 22
    cidr_blocks       = ["0.0.0.0/0"]
  }

  ingress {
    from_port         = 80
    protocol          = "tcp"
    to_port           = 80
    cidr_blocks       = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Security group for myAdmin"
  }
}


resource "aws_iam_instance_profile" "instance_pofile" {
  name                = "server"
  role                = aws_iam_role.S3role.name
}


 resource "aws_iam_role" "S3role" {
  name                = "EC2accessS3"
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.s3_access.json

 }

  resource "aws_iam_role_policy_attachment" "test-attach" {
  role                = aws_iam_role.S3role.name
  policy_arn          = data.aws_iam_policy.s3_access.arn
}

data "aws_iam_policy_document" "s3_access" {
  version             = "2012-10-17"
  statement {
    sid               = ""
    effect            = "Allow"
    actions           = ["sts:AssumeRole"]

      principals {
        type          = "Service"
        identifiers   = ["ec2.amazonaws.com"]
      }
  }
}
data "aws_iam_policy" "s3_access" {
  arn                 = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}