variable "project_name" {
  description = "项目名称前缀，将用于资源命名和标签"
  type        = string
}

variable "vpc_id" {
  description = "用于创建安全组的 VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "EC2 实例所在的子网 ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 实例规格"
  type        = string
}

variable "instance_count" {
  description = "EC2 实例数量（>=1）"
  type        = number
  default     = 1

  validation {
    condition     = var.instance_count >= 1 && var.instance_count % 1 == 0
    error_message = "instance_count 必须是大于等于 1 的整数。"
  }
}

variable "instance_name" {
  description = "EC2 实例 Name 标签（为空则默认：<project_name>-server）"
  type        = string
  default     = null
}

variable "ami_id" {
  description = "可选：直接指定 AMI ID（不指定则自动查找 Amazon Linux 2 的最新 AMI）"
  type        = string
  default     = null

  validation {
    condition     = var.ami_id == null || length(trimspace(var.ami_id)) > 0
    error_message = "ami_id 不能是空字符串；不指定请用 null 或直接移除该变量。"
  }
}

variable "ami_architecture" {
  description = "自动查找 AMI 时使用的架构：x86_64 或 arm64"
  type        = string
  default     = "x86_64"
  nullable    = false

  validation {
    condition     = contains(["x86_64", "arm64"], var.ami_architecture)
    error_message = "ami_architecture 仅支持 x86_64 或 arm64。"
  }
}

variable "ssh_ingress_cidr_blocks" {
  description = "允许 SSH(22) 入站访问的 IPv4 CIDR 列表（生产建议限制为你的 IP/网段）"
  type        = list(string)
  default     = []
  nullable    = false
}

variable "key_name" {
  description = "可选：用于 SSH 登录的 Key Pair 名称（不填也可创建实例，但无法通过 SSH 登录）"
  type        = string
  default     = null
}

variable "iam_instance_profile" {
  description = "可选：绑定到 EC2 的 IAM Instance Profile 名称（用于 SSM/访问 AWS API 等）"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "是否为实例分配公网 IP（null 表示使用子网默认设置）"
  type        = bool
  default     = null
}

variable "metadata_http_tokens" {
  description = "IMDSv2 http_tokens 设置：required 或 optional"
  type        = string
  default     = "optional"

  validation {
    condition     = contains(["required", "optional"], var.metadata_http_tokens)
    error_message = "metadata_http_tokens 仅支持 required 或 optional。"
  }
}

variable "metadata_http_put_response_hop_limit" {
  description = "IMDSv2 hop limit（1-64）"
  type        = number
  default     = 1

  validation {
    condition     = var.metadata_http_put_response_hop_limit >= 1 && var.metadata_http_put_response_hop_limit <= 64
    error_message = "metadata_http_put_response_hop_limit 必须在 1 到 64 之间。"
  }
}

variable "tags" {
  description = "可选：额外标签（会与 Provider default_tags 合并；资源 Name 标签由模块统一设置）"
  type        = map(string)
  default     = {}
  nullable    = false
}
