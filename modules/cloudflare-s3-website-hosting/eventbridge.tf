resource "aws_cloudwatch_event_rule" "lambda_trigger_event" {
  name        = var.prefix != "" ? "${var.prefix}-${var.lambda_trigger_event_name}" : var.lambda_trigger_event_name
  description = var.lambda_trigger_event_description

  schedule_expression = var.lambda_trigger_event_schedule_expression
}

resource "aws_cloudwatch_event_target" "lambda_eventbridge_target" {
  rule = aws_cloudwatch_event_rule.lambda_trigger_event.name
  arn  = aws_lambda_function.update_s3_bucket_policy.arn
}

resource "aws_lambda_permission" "eventbridge_lambda_permission" {
  statement_id  = var.eventbridge_lambda_permission_statement_id
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.update_s3_bucket_policy.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_trigger_event.arn
}
