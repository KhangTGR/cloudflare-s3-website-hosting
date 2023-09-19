locals {
  bucket_name = var.subdomain != null ? "${var.subdomain}.${var.domain}" : var.domain
}
