resource "aws_lambda_function" "self" {
  filename         = var.filename
  function_name    = var.name
  handler          = var.handler
  layers           = var.layers
  role             = aws_iam_role.self.arn
  runtime          = var.runtime
  source_code_hash = filebase64sha256(var.filename)
  tags             = var.tags
  timeout          = var.timeout

  depends_on = [
    aws_iam_role_policy_attachment.self,
    aws_cloudwatch_log_group.self,
  ]
}

# AWS Lambda's inheriently try to use a log group of path /aws/lambda/function_name
# Putting this here just gives us better management of the group than allowing it to be created by the Lambda function
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function#cloudwatch-logging-and-permissions
resource "aws_cloudwatch_log_group" "self" {
  name              = "/aws/lambda/${var.name}"
  kms_key_id        = var.cloudwatch["kms_key_id"]
  retention_in_days = var.cloudwatch["retention_in_days"]
  tags              = var.tags
}
