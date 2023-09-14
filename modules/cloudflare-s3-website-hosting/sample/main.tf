module "cloudflare-s3-website-hosting" {
  source = "./modules/cloudflare-s3-website-hosting"

  # Required variables
  bucket_name = "Your bucket name"
  region      = "Your chosen region"
}

output "website_url" {
  description = "The URL of the hosted static website in Amazon S3."
  value       = module.cloudflare-s3-website-hosting.website_url
}

# ============ MUST HAVE ============
output "bucket_name" {
  description = "The name of the bucket"
  value       = module.cloudflare-s3-website-hosting.bucket_name
}
