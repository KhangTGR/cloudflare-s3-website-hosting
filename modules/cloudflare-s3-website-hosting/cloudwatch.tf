resource "aws_cloudwatch_log_group" "lambda_logs" {
  name = "/aws/lambda/${aws_lambda_function.update_s3_bucket_policy.function_name}"
}

resource "aws_cloudwatch_log_stream" "lambda_logs_stream" {
  name           = aws_lambda_function.update_s3_bucket_policy.function_name
  log_group_name = aws_cloudwatch_log_group.lambda_logs.name
}
