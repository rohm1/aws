variable "bucket_prefix" {
  type = string
}

variable "allowed_ips" {
  description = "List of CIDR blocks from which the IAM user is allowed to access the bucket. Example: [\"203.0.113.0/24\"]"
  type        = list(string)
}
