module "vpc" {
  source = "./modules/01_vpc"
}
module "subnet" {
  source = "./modules/02_subnets"
  vpc_id = module.vpc.vpc_id
}
module "route_table" {
  source                  = "./modules/03_route-table"
  vpc_id                  = module.vpc.vpc_id
  private_subnet_B_id     = module.subnet.private_subnet-B-id-subnet
  private_subnet_A_id     = module.subnet.private_subnet-A-id-subnet
  public_subnet-B-id      = module.subnet.public_subnet-B-id-subnet
  public_subnet-A-id      = module.subnet.public_subnet-A-id-subnet
  aws_internet_gateway_id = module.vpc.internet_gateway_id
}
module "security_groups" {
  source            = "./modules/04-security_group"
  vpc_id            = module.vpc.vpc_id
  admin_cidr_blocks = var.admin_cidr_blocks
}
## RDS Modules
module "RDS-Parameter-groups" {
  source = "./modules/05-RDS/Parameter-groups"
}
module "RDS-Subnet-groups" {
  source              = "./modules/05-RDS/Subnet-groups"
  private_subnet_B_id = module.subnet.private_subnet-B-id-subnet
  private_subnet_A_id = module.subnet.private_subnet-A-id-subnet
  vpc_id              = module.vpc.vpc_id
}
module "RDS" {
  source                   = "./modules/05-RDS"
  rds_sg_id                = module.security_groups.backend_vp_app_sg_id
  RDS_parameter_group_name = module.RDS-Parameter-groups.parameter_group_name
  RDS_subnet_group_name    = module.RDS-Subnet-groups.RDS_subnet_group_name
  vpc_id                   = module.vpc.vpc_id

}
##  ElastiCache Modules
module "ElastiCache-parameter-groups" {
  source = "./modules/06_ElastiCache/Parameter-groups"

}
module "ElastiCache-Subnet-groups" {
  source              = "./modules/06_ElastiCache/Subnet-groups"
  private_subnet_B_id = module.subnet.private_subnet-B-id-subnet
  private_subnet_A_id = module.subnet.private_subnet-A-id-subnet
  vpc_id              = module.vpc.vpc_id
}
module "ElastiCache" {
  source                         = "./modules/06_ElastiCache"
  vpc_id                         = module.vpc.vpc_id
  elasti_cache_sg_id             = module.security_groups.backend_vp_app_sg_id
  memcached_parameter_group_name = module.ElastiCache-parameter-groups.memcached_parameter_group_name
  memcached_subnet_group_name    = module.ElastiCache-Subnet-groups.memcached_subnet_group_name

}

# Amazon MQ Module
module "Amazon-MQ" {
  source               = "./modules/07_Amazon MQ"
  Amazon-MQ-sg_id      = module.security_groups.backend_vp_app_sg_id
  vpc_id               = module.vpc.vpc_id
  Amazon-MQ-subnet_ids = [module.subnet.private_subnet-A-id-subnet, module.subnet.private_subnet-B-id-subnet]
}
# Instances Module
module "instances" {
  source                     = "./modules/08_instances"
  public_subnet_id           = module.subnet.public_subnet-A-id-subnet
  ephemeral_worker_subnet_id = module.subnet.public_subnet-B-id-subnet
  tomcat_sg_id               = module.security_groups.tomcat_sg_id
  ephemeral_worker_sg_id     = module.security_groups.ephemeral_worker_sg_id
  depends_on                 = [module.RDS, module.ElastiCache, module.Amazon-MQ]
  rds_address                = module.RDS.RDS_Address
  db_username                = module.RDS.username
  db_password                = module.RDS.password
  db_name                    = module.RDS.initial_db_name
  rds_endpoint               = module.RDS.RDS_Endpoint
  elasticache_endpoint       = module.ElastiCache.ElastiCache_Endpoint
  rabbitmq_endpoint          = module.Amazon-MQ.RabbitMQ_broker_endpoint
  rabbitmq_username          = module.Amazon-MQ.Amazon-MQ-username
  rabbitmq_password          = module.Amazon-MQ.Amazon-MQ-password
}

# CLB Module
module "CLB" {
  source          = "./modules/09_CLB"
  subnets         = [module.subnet.public_subnet-B-id-subnet, module.subnet.public_subnet-A-id-subnet]
  security_groups = [module.security_groups.clb_sg_id]
  instances       = [module.instances.tomcat_instance_id]
  depends_on      = [module.instances.tomcat_instance_id]
}
