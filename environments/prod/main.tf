# 1. 定义 Provider
provider "aws" {
  region = "us-west-2" # 生产环境可能在不同区域
}

# 2. 调用 VPC 模块
module "vpc" {
  source       = "../../modules/vpc"
  env          = "prod"
  project_name = "aws-pro"
  vpc_cidr     = "10.1.0.0/16" # 生产环境使用独立网段，防止以后做对等连接冲突
}

# 3. 调用 EC2 模块
module "ec2" {
  source        = "../../modules/ec2"
  instance_type = "t3.medium"
  instance_count = 3           # 部署多台实现高可用
  vpc_id        = module.vpc.vpc_id
}


