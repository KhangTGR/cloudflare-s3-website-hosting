module "cloudflare-s3-website-hosting" {
  source = "./modules/cloudflare-s3-website-hosting"

  bucket_name = "blog-test.khangtgr.com"
  region      = "ap-southeast-1"
}

output "website_url" {
  description = "The URL of the hosted static website in Amazon S3."
  value       = module.cloudflare-s3-website-hosting.website_url
}

output "bucket_name" {
  description = "The name of the bucket"
  value       = module.cloudflare-s3-website-hosting.bucket_name
}
