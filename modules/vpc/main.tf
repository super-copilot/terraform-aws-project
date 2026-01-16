# 创建 VPC
resource "aws_vpc" "vpc-1" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# 创建子网
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc-1.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true # 自动分配公网IP
  tags = {
    Name = "${var.project_name}-public-subnet"
  }
}

# 创建互联网网关
resource "aws_internet_gateway" "vpc-1" {
  vpc_id = aws_vpc.vpc-1.id
}

# 创建路由表并允许出站流量
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-1.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

