
provider "aws" {
  region = var.aws_region

  # 为所有资源打上默认标签
  default_tags {
    tags = {
      Environment = "AWS-Pre"
      Project     = "Terraform-Pre"
      ManagedBy   = "Terraform"
    }
  }
}
