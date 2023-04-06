# In order to set the availability zones for resources based on the region we choose below block is used
locals {
  production_availability_zones = ["${var.region}a", "${var.region}b"]
}

# Networking module to create VPC and its resources
module "Networking" {
  source                  = "./modules/Networking"
  region                  = var.region
  environment             = var.environment
  vpc_cidr                = var.vpc_cidr
  public_subnets_cidr     = var.public_subnets_cidr
  private_subnets_cidr    = var.private_subnets_cidr
  private_db_subnets_cidr = var.private_db_subnets_cidr
  availability_zones      = local.production_availability_zones
}

# Servers module to create EC2 and its resources
module "Servers" {
  source                  = "./modules/Servers"
  vpc_id                  = module.Networking.vpc_id
  environment             = var.environment
  public_subnets_cidr     = var.public_subnets_cidr
  private_subnets_cidr    = var.private_subnets_cidr
  public_subnets_id       = element(module.Networking.public_subnets_id, 0)
  private_subnets_id      = element(module.Networking.private_subnets_id, 0)
  security_groups_ids     = module.Networking.default_sg_id
  alb_security_groups_ids = module.Loadbalancer.alb_security_groups_ids
  availability_zones      = local.production_availability_zones
}

# Loadbalancer module to create Load Balancer and its resources
module "Loadbalancer" {
  source               = "./modules/Loadbalancer"
  environment          = var.environment
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  public_subnets_id    = element(module.Networking.public_subnets_id, 0)
  private_subnets_id   = module.Networking.private_subnets_id
  vpc_id               = module.Networking.vpc_id
  ec2_instances_ids    = element(module.Servers.ec2_instances_ids, 0)
}

# Database module to create RDS Database and its resources
module "Database" {
  source                  = "./modules/Database"
  vpc_id                  = module.Networking.vpc_id
  private_db_subnets_id   = element(module.Networking.private_db_subnets_id, 0)
  ec2_security_groups_ids = module.Servers.ec2_security_groups_ids
  settings                = var.settings
  db_username             = var.db_username
  db_password             = var.db_password
}

