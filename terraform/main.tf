module "vpc" {
  source = "./modules/01-vpc"
}
module "subnets" {
  source = "./modules/02-subnets"
  vpc_id = module.vpc.vpc_id
}
module "natgw" {
  source           = "./modules/03-natgw-eip"
  public_subnet_id = module.subnets.public_subnet_id

}
module "route_tables" {
  source            = "./modules/04-route_tables"
  vpc_id            = module.vpc.vpc_id
  natgw_id          = module.natgw.natgw_id
  igw_id            = module.vpc.igw_id
  public_subnet_id  = module.subnets.public_subnet_id
  private_subnet_id = module.subnets.private_subnet_id
}
module "security_groups" {
  source              = "./modules/05-security_groups"
  vpc_id              = module.vpc.vpc_id
  public_subnet_id    = module.subnets.public_subnet_id
  private_subnet_id   = module.subnets.private_subnet_id
  public_subnet_cidr  = module.subnets.public_subnet_cidr
  private_subnet_cidr = module.subnets.private_subnet_cidr
  igw_id              = module.vpc.igw_id

}
module "instances" {
  source            = "./modules/06-instances"
  master_sg_id      = module.security_groups.master_sg_id
  worker_sg_id      = module.security_groups.worker_sg_id
  bastion_sg_id     = module.security_groups.bastion_sg_id
  public_subnet_id  = module.subnets.public_subnet_id
  private_subnet_id = module.subnets.private_subnet_id
}
module "route53" {
  source             = "./modules/07-Route-53"
  vpc_id             = module.vpc.vpc_id
  master_private_ip  = module.instances.master_private_ip
  worker1_private_ip = module.instances.worker1_private_ip
  worker2_private_ip = module.instances.worker2_private_ip
  bastion_public_ip  = module.instances.bastion_public_ip
}
