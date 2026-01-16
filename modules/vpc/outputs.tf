# 
output "vpc_id" {
  description = "创建的 VPC ID"
  value       = aws_vpc.vpc-1.id
}

output "subnet_id" {
  description = "创建的公网子网 ID"
  value       = aws_subnet.public.id
}

