variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_name" {}

variable "aws_front_ami" {}

variable "aws_docu_ami" {}

variable "aws_db_ami" {}

variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "key_path" {}
