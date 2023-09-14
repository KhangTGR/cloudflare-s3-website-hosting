resource "aws_lambda_function" "update_s3_bucket_policy" {
  filename      = data.archive_file.lambda_function_code_zip.output_path
  function_name = var.prefix != "" ? "${var.prefix}-${var.lambda_function_name}" : var.lambda_function_name
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.9"
  depends_on    = [aws_iam_role_policy_attachment.lambda_policy_attachment]
  description   = var.lambda_function_description

  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
    }
  }
}

resource "null_resource" "trigger_lambda_execution" {
  triggers = {
    lambda_function_arn = aws_lambda_function.update_s3_bucket_policy.arn
  }

  provisioner "local-exec" {
    command = "aws lambda invoke --function-name ${aws_lambda_function.update_s3_bucket_policy.function_name} --invocation-type RequestResponse /tmp/output.json"
  }

  depends_on = [aws_lambda_function.update_s3_bucket_policy]
}
