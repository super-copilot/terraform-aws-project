variable "project_name" {
  description = "Project name prefix for tags"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name (globally unique)"
  type        = string
}

variable "versioning_enabled" {
  description = "Enable versioning"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Allow destroying non-empty bucket (keep false in production)"
  type        = bool
  default     = false
}

variable "sse_algorithm" {
  description = "SSE algorithm: AES256 or aws:kms"
  type        = string
  default     = "AES256"

  validation {
    condition     = contains(["AES256", "aws:kms"], var.sse_algorithm)
    error_message = "sse_algorithm must be AES256 or aws:kms."
  }
}

variable "kms_key_id" {
  description = "Optional: KMS key ID/ARN (required when sse_algorithm=aws:kms)"
  type        = string
  default     = null

  validation {
    condition     = var.sse_algorithm != "aws:kms" || (var.kms_key_id != null && length(trimspace(var.kms_key_id)) > 0)
    error_message = "kms_key_id is required when sse_algorithm=aws:kms."
  }
}

variable "tags" {
  description = "Additional tags (Name tag is set by module)"
  type        = map(string)
  default     = {}
  nullable    = false
}
