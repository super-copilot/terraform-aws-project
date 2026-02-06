
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "my-web-app"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "instance_count" {
  description = "EC2 instance count"
  type        = number
  default     = 1
}

variable "ami_id" {
  description = "Optional: fixed AMI ID"
  type        = string
  default     = null
}

variable "ami_architecture" {
  description = "AMI architecture: x86_64 or arm64"
  type        = string
  default     = "x86_64"
}

variable "ssh_ingress_cidr_blocks" {
  description = "Allowed SSH ingress CIDR list"
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "Optional: EC2 key pair name"
  type        = string
  default     = null
}

variable "iam_instance_profile" {
  description = "Optional: IAM instance profile name"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Associate public IP (null uses subnet default)"
  type        = bool
  default     = null
}

variable "metadata_http_tokens" {
  description = "IMDSv2 http_tokens setting: required or optional"
  type        = string
  default     = "optional"
}

variable "metadata_http_put_response_hop_limit" {
  description = "IMDSv2 hop limit (1-64)"
  type        = number
  default     = 1
}

variable "s3_bucket_name" {
  description = "S3 bucket name (globally unique)"
  type        = string
}

variable "s3_versioning_enabled" {
  description = "Enable S3 versioning"
  type        = bool
  default     = true
}

variable "s3_force_destroy" {
  description = "Allow destroying non-empty bucket"
  type        = bool
  default     = false
}

variable "s3_sse_algorithm" {
  description = "SSE algorithm: AES256 or aws:kms"
  type        = string
  default     = "AES256"
}

variable "s3_kms_key_id" {
  description = "Optional: KMS key ID/ARN for aws:kms"
  type        = string
  default     = null
}

variable "extra_tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
