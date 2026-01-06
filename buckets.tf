module "buckets" {
  for_each      = toset(["nextcloud", "state"])
  source        = "./modules/bucket"
  bucket_prefix = "${each.key}-"
}
