# Define an AWS Lambda function to update S3 bucket policy based on CloudFlare IPs.
resource "aws_lambda_function" "lambda_function" {
  filename      = data.archive_file.code_zip.output_path
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.9"
  depends_on    = [aws_iam_role_policy_attachment.policy_role_attachment]
  description   = var.lambda_function_description

  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
    }
  }
}
