module "bucket_users" {
  for_each = {
    nextcloud : {
      bucket : "nextcloud",
      rw : true,
    }
    piwigo : {
      bucket : "nextcloud",
      rw : false,
    }
    mama : {
      bucket : "mama",
      rw : true
    }
  }
  source      = "./modules/bucket_user"
  allowed_ips = var.allowed_ips
  bucket_arn  = module.buckets[each.value.bucket].bucket_arn
  name_prefix = each.key
  rw          = each.value.rw
}
