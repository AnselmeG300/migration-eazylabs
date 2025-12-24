resource "aws_lambda_function" "eazylabs_lambda" {
  filename      = "eazy_labs_lambda.zip"
  function_name = local.function_name
  role          = aws_iam_role.eazylabs_lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  timeout       = 300

  environment {
    variables = {
      TARGET_GROUP_ARN          = aws_lb_target_group.pwd_eazylabs_lb_tg.arn
      CLOUDWATCH_DASHBOARD_NAME = local.cloudwatch_dashboard_name
      ASG_NAME                  = local.asg_name
    }
  }
}