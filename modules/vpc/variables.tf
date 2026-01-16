variable "project_name" {
  description = "项目的名称，将用于资源打标签"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC 的 CIDR 地址范围"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "公网子网的 CIDR 地址范围"
  type        = string
  default     = "10.0.1.0/24"
}


