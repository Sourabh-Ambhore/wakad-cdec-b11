module "vpc_module" {
  source      = "../module/vpc"
  vpc_cidr    = var.first_cidr
  vpc_name    = var.first_vpc
  subent_cidr = var.first_cidr_subnet
  az          = var.first_az
  subnet_name = var.first_subnet_name
  igw_name    = var.first_igw_name
}