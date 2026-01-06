variable "name_prefix" {
  type = string
}

variable "bucket_arn" {
  type = string
}

variable "rw" {
  description = "Whether to apply RW (read-write) or RO (read-only) permissions to the user"
}

variable "allowed_ips" {
  description = "List of CIDR blocks from which the IAM user is allowed to access the bucket. Example: [\"203.0.113.0/24\"]"
  type        = list(string)
}
