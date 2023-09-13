data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "archive_file" "code_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/"
  output_path = "${path.module}/lambda/lambda_function.zip"
}
