# 查询最新的 Amazon Linux 2 AMI ID（可通过 var.ami_id 覆盖）
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-${var.ami_architecture}-gp2", "amzn2-ami-hvm-*-${var.ami_architecture}-gp3"]
  }

  filter {
    name   = "architecture"
    values = [var.ami_architecture]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  ami_id = (
    var.ami_id != null && length(trimspace(var.ami_id)) > 0
  ) ? var.ami_id : data.aws_ami.amazon_linux_2.id

  base_instance_name = (
    var.instance_name != null && length(trimspace(var.instance_name)) > 0
  ) ? var.instance_name : "${var.project_name}-server"

  base_tags = var.tags
  sg_tags   = merge(var.tags, { Name = "${var.project_name}-sg" })
}

# 创建安全组（默认仅开放 SSH 22；建议用 var.ssh_ingress_cidr_blocks 限制到你的 IP）
resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-sg"
  description = "Security group for ${var.project_name}"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = toset(var.ssh_ingress_cidr_blocks)
    content {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.sg_tags
}

# 创建 EC2 实例
resource "aws_instance" "app" {
  count                       = var.instance_count
  ami                         = local.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = var.key_name
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = var.associate_public_ip_address

  # 元数据服务：默认不强制 IMDSv2；生产建议设置为 required
  metadata_options {
    http_tokens                 = var.metadata_http_tokens
    http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
  }

  tags = merge(local.base_tags, {
    Name = var.instance_count > 1 ? format("%s-%02d", local.base_instance_name, count.index + 1) : local.base_instance_name
  })
}
