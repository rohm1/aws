module "s3_photos" {
  source        = "./modules/bucket"
  allowed_ips   = var.allowed_ips
  bucket_prefix = "photos-"
}
