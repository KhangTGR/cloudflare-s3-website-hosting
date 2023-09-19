data "aws_region" "current_region" {}

data "aws_caller_identity" "current_identity" {}

data "archive_file" "lambda_function_code_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/"
  output_path = "${path.module}/lambda/lambda_function.zip"
}

data "cloudflare_zones" "domain" {
  filter {
    name = var.domain
  }
}
