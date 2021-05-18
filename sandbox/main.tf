

module "vpc" {
  source              = "../modules/tf-module-vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  igw                 = module.ig.igw_id
  natgw_ids           = module.natgw.natgw_ids
  name                = var.name
  project             = var.project
  environment         = var.environment
  managedby           = var.managedby

}

module "ig" {
  source      = "../modules/tf-module-ig"
  vpc_id      = module.vpc.vpc_id
  name        = var.name
  project     = var.project
  environment = var.environment
  managedby   = var.managedby
}

module "natgw" {
  source            = "../modules/tf-module-nat"
  public_subnet_ids = module.vpc.public_subnet_ids
  name              = var.name
  project           = var.project
  environment       = var.environment
  managedby         = var.managedby
}

module "domain_reggaetech" {
  source      = "../modules/tf-module-dns"
  domain_name = "reggaetech.org"

}

module "domain_local" {
  source      = "../modules/tf-module-dns"
  domain_name = "local.internal"
  vpc_id      = module.vpc.vpc_id
}
