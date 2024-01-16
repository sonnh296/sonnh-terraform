resource "aws_instance" "s_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.vpc_security_group_id]
  subnet_id              = var.public_subnet_id
  key_name               = data.aws_key_pair.ssh_key.key_name
  tags = {
    Name = "s_server"
  }
}

data "aws_key_pair" "ssh_key" {
  key_name           = "s-ssh-key"
  include_public_key = true
}
