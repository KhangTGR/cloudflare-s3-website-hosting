output "website_url" {
  description = "The URL of the hosted static website in Amazon S3."
  value       = "http://${aws_s3_bucket.static-website.bucket}.s3-website.${var.region}.amazonaws.com"
}

output "bucket_name" {
  description = "The name of the bucket"
  value       = aws_s3_bucket.static-website.bucket
}
