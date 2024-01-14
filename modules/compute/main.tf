data "aws_ssm_parameter" "s_ami" {
    name = "s_ami"
    value = "ami-0fa377108253bf620"
}


# Launch template for bastion

resource "aws_launch_template" "s_bastion" {
    image_id = data.aws_ssm_parameter.s_ami.value
    instance_type = var.instance_type
    vpc_security_group_ids = var.s_bastion_sg

    tags = {
        Name = "s_bastion"
    }
}


resource "aws_autoscaling_group" "s_bastion" {
    name     = "s_bastion"
    min_size = 1
    max_size = 2
    desired_capacity = 1
    vpc_zone_identifier = var.s_public_subnet

    launch_template {
        id = aws_launch_template.s_bastion.id
        version = "$Latest"
    }
}

# Launch template for server

resource "aws_launch_template" "s_bastion" {
    image_id = data.aws_ssm_parameter.s_ami.value
    instance_type = var.instance_type
    vpc_security_group_ids = var.s_bastion_sg
    key_name = var.key_name

    tags = {
        Name = "s_bastion"
    }
}