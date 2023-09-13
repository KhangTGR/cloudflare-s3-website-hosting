# Define an S3 bucket for the static website files.
resource "aws_s3_bucket" "static-website" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    Name = "static-website"
  }
}

# Configure the static website properties of the S3 bucket.
resource "aws_s3_bucket_website_configuration" "static-website" {
  bucket = aws_s3_bucket.static-website.id

  # Specify the index and error documents for the static website.
  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }
}

# Enable versioning for the S3 bucket to track object versions.
resource "aws_s3_bucket_versioning" "static-website" {
  bucket = aws_s3_bucket.static-website.id
  versioning_configuration {
    status = var.versioning_status
  }
}

# Configure ownership controls for the S3 bucket.
resource "aws_s3_bucket_ownership_controls" "static-website" {
  bucket = aws_s3_bucket.static-website.id
  rule {
    object_ownership = var.object_ownership_rule
  }
}

# Configure public access block settings for the S3 bucket.
resource "aws_s3_bucket_public_access_block" "static-website" {
  bucket = aws_s3_bucket.static-website.id

  block_public_acls       = var.block_public_acls_status
  block_public_policy     = var.block_public_policy_status
  ignore_public_acls      = var.ignore_public_acls_status
  restrict_public_buckets = var.restrict_public_buckets_status
}

# Configure the S3 bucket access control list (ACL).
resource "aws_s3_bucket_acl" "static-website" {
  depends_on = [
    aws_s3_bucket_ownership_controls.static-website,
    aws_s3_bucket_public_access_block.static-website,
  ]

  bucket = aws_s3_bucket.static-website.id
  acl    = var.bucket_acl_status
}
