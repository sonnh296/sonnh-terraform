module "network-resources" {
  source = "./modules/networking"
}

module "security-resources" {
  source = "./modules/security-group"
  vpc_id = module.network-resources.vpc_id.id
}

module "ec2-resources" {
  source                = "./modules/compute"
  vpc_id                = module.network-resources.vpc_id.id
  public_subnet_id      = module.network-resources.public_subnets.id
  vpc_security_group_id = module.security-resources.allow_ssh_http_sg.id
}
