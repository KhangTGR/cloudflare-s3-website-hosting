resource "cloudflare_record" "website_cname" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.subdomain != null ? var.subdomain : "@"
  value   = "${aws_s3_bucket.static_website_bucket.bucket}.s3-website.${var.region}.amazonaws.com"
  type    = "CNAME"

  ttl             = 1
  proxied         = true
  allow_overwrite = true
}

resource "cloudflare_page_rule" "https_enforcing" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  target  = "*.${var.domain}/*"
  actions {
    always_use_https = true
  }
}
