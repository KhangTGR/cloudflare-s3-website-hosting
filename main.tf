module "cloudflare-s3-website-hosting" {
  source = "./modules/cloudflare-s3-website-hosting"

  # Required variables
  domain               = var.domain
  subdomain            = var.subdomain
  cloudflare_api_token = var.cloudflare_api_token
  region               = var.region

  # Optional variables
  prefix = var.prefix
}
