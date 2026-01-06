module "buckets" {
  for_each      = toset(["nextcloud", "state"])
  source        = "./modules/bucket"
  allowed_ips   = var.allowed_ips
  bucket_prefix = "${each.key}-"
}
