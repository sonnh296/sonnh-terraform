resource "aws_instance" "blog_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.allow_ssh_myip_sg_id, var.allow_http_sg_id]
  subnet_id              = var.public_subnet_id
  key_name               = data.aws_key_pair.ssh_key.key_name
  tags = {
    Name = "blog server"
  }
}

resource "aws_instance" "blog_db" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.allow_ssh_all_sg_id, var.allow_mysql_sg_id]
  subnet_id              = var.private_subnet_id
  key_name               = data.aws_key_pair.ssh_key.key_name
  tags = {
    Name = "blog db"
  }
}

data "aws_key_pair" "ssh_key" {
  key_name           = "s-ssh-key"
  include_public_key = true
}
