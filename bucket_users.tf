module "bucket_user_nextcloud_rw" {
  source      = "./modules/bucket_user"
  allowed_ips = var.allowed_ips
  bucket_arn  = module.buckets["nextcloud"].bucket_arn
  name_prefix = "nextcloud"
  rw          = true
}
