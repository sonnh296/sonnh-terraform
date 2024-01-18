variable "ami_id" {
  default = "ami-0fa377108253bf620"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "vpc_id" {
  type = string
}
variable "public_subnet_id" {
  type = string
}
variable "private_subnet_id" {
  type = string
}
variable "allow_ssh_myip_sg_id" {
  type = string
}
variable "allow_ssh_all_sg_id" {
  type = string
}
variable "allow_http_sg_id" {
  type = string
}
variable "allow_mysql_sg_id" {
  type = string
}

