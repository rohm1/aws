module "buckets" {
  for_each      = toset(["nextcloud", "state", "mama"])
  source        = "./modules/bucket"
  bucket_prefix = each.key
}
