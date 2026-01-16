# 调用vpc模块
module "network" {
  source       = "./modules/vpc"
  vpc_cidr     = "10.0.0.0/16"
  subnet_cidr  = "10.0.1.0/24"
  project_name = var.project_name
}

# 调用ec2模块
module "compute" {
  source        = "./modules/ec2"
  project_name  = var.project_name
  instance_type = var.instance_type
  vpc_id        = module.network.vpc_id
  subnet_id     = module.network.subnet_id
}


