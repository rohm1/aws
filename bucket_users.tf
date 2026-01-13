locals {
  bucket_users = {
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
      allowed_ips : ["0.0.0.0/0"],
      rw : true,
    }
    backup : {
      bucket : "backup",
      rw : true,
    }
  }
}

module "bucket_users" {
  for_each = local.bucket_users

  source      = "./modules/bucket_user"
  allowed_ips = lookup(each.value, "allowed_ips", null) != null ? each.value.allowed_ips : var.allowed_ips
  bucket_arn  = module.buckets[each.value.bucket].bucket_arn
  name_prefix = each.key
  rw          = each.value.rw
}
