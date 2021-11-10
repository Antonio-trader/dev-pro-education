variable "ami" {
  type = string
}

#variable "name" {
#  type = map(string)
#}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "key_name" {
  type = string
}

variable "user_data" {
  type = any
}

#variable "name_of_vm" {
#  type = string
#}