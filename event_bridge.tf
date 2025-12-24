resource "aws_cloudwatch_event_rule" "every_10_minutes" {
  name                = "every-10-minutes-rule"
  description         = "Règle CloudWatch Event qui se déclenche toutes les 10 minutes"
  schedule_expression = "cron(0/10 * * * ? *)" # Cron expression pour toutes les 10 minutes
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule = aws_cloudwatch_event_rule.every_10_minutes.name
  arn  = aws_lambda_function.eazylabs_lambda.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.eazylabs_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_10_minutes.arn
}

