resource "aws_s3_bucket" "static_website_bucket" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "static_website_configuration" {
  bucket = aws_s3_bucket.static_website_bucket.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }
}

resource "aws_s3_bucket_versioning" "static_website_versioning" {
  bucket = aws_s3_bucket.static_website_bucket.id
  versioning_configuration {
    status = var.versioning_status
  }
}

resource "aws_s3_bucket_ownership_controls" "static_website_ownership_controls" {
  bucket = aws_s3_bucket.static_website_bucket.id
  rule {
    object_ownership = var.object_ownership_rule
  }
}

resource "aws_s3_bucket_public_access_block" "static_website_public_access_block" {
  bucket = aws_s3_bucket.static_website_bucket.id

  block_public_acls       = var.block_public_acls_status
  block_public_policy     = var.block_public_policy_status
  ignore_public_acls      = var.ignore_public_acls_status
  restrict_public_buckets = var.restrict_public_buckets_status
}

resource "aws_s3_bucket_acl" "static_website_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.static_website_ownership_controls,
    aws_s3_bucket_public_access_block.static_website_public_access_block,
  ]

  bucket = aws_s3_bucket.static_website_bucket.id
  acl    = var.bucket_acl_status
}
