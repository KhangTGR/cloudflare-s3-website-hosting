# Define CloudWatch Logs group for Lambda function logs.
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name = "/aws/lambda/${aws_lambda_function.lambda_function.function_name}"
}

# Define CloudWatch Logs stream for Lambda function logs.
resource "aws_cloudwatch_log_stream" "lambda_log_stream" {
  name           = aws_lambda_function.lambda_function.function_name
  log_group_name = aws_cloudwatch_log_group.lambda_log_group.name
}
