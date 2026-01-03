module "s3_state" {
  source        = "./modules/bucket"
  allowed_ips   = var.allowed_ips
  bucket_prefix = "state-"
}