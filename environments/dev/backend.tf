# 
terraform {
  backend "s3" {
    bucket         = "aws-terraform-state-storage"
    key            = "dev/terraform.tfstate" # 关键：不同环境路径不同
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"        # 用于防止多人同时修改
  }
}
