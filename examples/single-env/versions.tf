terraform {
  required_version = ">= 1.5.0" # 建议支持较新版本
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # 使用 5.x 版本的 AWS Provider
    }
  }
}