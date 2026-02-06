locals {
  vpc_tags           = merge(var.tags, { Name = "${var.project_name}-vpc" })
  public_subnet_tags = merge(var.tags, { Name = "${var.project_name}-public-subnet" })
  igw_tags           = merge(var.tags, { Name = "${var.project_name}-igw" })
  public_rt_tags     = merge(var.tags, { Name = "${var.project_name}-public-rt" })
}

# 创建 VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags                 = local.vpc_tags
}

# 创建子网
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true # 自动分配公网IP
  tags                    = local.public_subnet_tags
}

# 创建互联网网关
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = local.igw_tags
}

# 创建路由表并允许出站流量
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = local.public_rt_tags
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
