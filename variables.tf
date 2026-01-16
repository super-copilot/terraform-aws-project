
variable "aws_region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "aws-pre"
  type        = string
  default     = "my-web-app"
}

variable "instance_type" {
  description = "EC2 instance specifications"
  type        = string
  default     = "t2.micro"
}


