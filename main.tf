module "network-resources" {
  source = "./modules/networking"
}

module "security-resources" {
  source = "./modules/security-group"
  vpc_id = module.network-resources.vpc.id
}

module "ec2-resources" {
  source               = "./modules/compute"
  vpc_id               = module.network-resources.vpc.id
  public_subnet_id     = module.network-resources.public_subnets.id
  private_subnet_id    = module.network-resources.private_subnets.id
  allow_http_sg_id     = module.security-resources.allow_http_sg.id
  allow_ssh_myip_sg_id = module.security-resources.allow_ssh_myip_sg.id
  allow_ssh_all_sg_id  = module.security-resources.allow_ssh_all_sg.id
  allow_mysql_sg_id    = module.security-resources.allow_mysql_sg.id
}
