locals {
  buckets = ["nextcloud", "state", "mama", "backup"]
}

module "buckets" {
  for_each = toset(local.buckets)

  source        = "./modules/bucket"
  bucket_prefix = each.key
}
