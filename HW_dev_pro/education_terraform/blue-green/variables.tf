variable "image_id" {
  type            = string
  description     = "The id of the machine image (AMI) to use for the server."
  default         = "ami-047e03b8591f2d48a"
}

variable "bastion_image_id" {
  type            = string
  default         = "ami-0a49b025fffbbdac6"
}

variable "zone_id" {
  type            = string
  default         = "1fbc7073a64e53e845e73af239389e74"
}

variable "email" {
  type            = string
  default         = "anton001000@gmail.com"
}

variable "cloudflare_api_key" {
  type            = string
  default         = "c1eb6e696ac6671a2d289344b5ff9dfac992d"
}

variable "instance_type" {
  type            = string
  default         = "t2.micro"
}

variable "cidr_block_for_vpc" {
  type            = string
  default         = "192.168.0.0/16"
}

variable "cidr_block_for_public_subnet_1a" {
  type            = string
  default         = "192.168.100.0/24"
}

variable "cidr_block_for_public_subnet_1b" {
  type            = string
  default         = "192.168.101.0/24"
}

variable "key_name" {
  type            = string
  default         = "Dnipro-KP"
}

variable "region" {
  type            = string
  default         = "eu-central-1"
}

variable "subnet_1a" {
  type            = string
  default         = "eu-central-1a"
}

variable "subnet_1b" {
  type            = string
  default         = "eu-central-1b"
}

variable "name_for_alb" {
  type            = string
  default         = "alb_for_dev_pro"
}

variable "color" {
  type            = string
}