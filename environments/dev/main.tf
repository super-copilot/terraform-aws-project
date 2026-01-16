# 1. 定义 Provider
provider "aws" {
  region = "us-east-1"
}

# 2. 调用 VPC 模块
module "vpc" {
  source       = "../../modules/vpc" # 指向共享模块
  env          = "dev"
  project_name = "aws-dev"
  vpc_cidr     = "10.0.0.0/16"
}

# 3. 调用 EC2 模块
module "ec2" {
  source          = "../../modules/ec2"
  vpc_id          = module.vpc.vpc_id
  instance_type   = "t2.micro"
  instance_count  = 1
}

