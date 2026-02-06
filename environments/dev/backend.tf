terraform {
  # dev 环境使用本地状态（多人协作可用远端方案，这里保持本地）
  backend "local" {
    path = "terraform.tfstate"
  }
}
