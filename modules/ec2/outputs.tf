output "instance_id" {
  description = "EC2 实例 ID（当 instance_count=1 时使用）"
  value       = aws_instance.app[0].id
}

output "public_ip" {
  description = "EC2 实例公网 IP（当 instance_count=1 时使用；若未分配则为空）"
  value       = aws_instance.app[0].public_ip
}

output "instance_ids" {
  description = "EC2 实例 ID 列表"
  value       = [for instance in aws_instance.app : instance.id]
}

output "public_ips" {
  description = "EC2 实例公网 IP 列表（若未分配则为空）"
  value       = [for instance in aws_instance.app : instance.public_ip]
}

output "security_group_id" {
  description = "EC2 安全组 ID"
  value       = aws_security_group.web_sg.id
}

output "ami_id" {
  description = "实际使用的 AMI ID"
  value       = aws_instance.app[0].ami
}
