variable "ami_id" {
  default = "ami-0fa377108253bf620"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_id" {
  type = string
}

variable "vpc_security_group_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}
