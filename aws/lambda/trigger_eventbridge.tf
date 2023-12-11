##
## Cron (Schedule expression)
##
resource "aws_lambda_permission" "schedule_expression" {
  for_each = { for i in var.eventbridge_schedule_expression : i["name"] => i }

  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.self.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.schedule_expression[each.key].arn
  statement_id  = "AllowExecutionEventBridgeScheduleExpression"
}

resource "aws_cloudwatch_event_target" "schedule_expression" {
  for_each = { for i in var.eventbridge_schedule_expression : i["name"] => i }

  arn  = aws_lambda_function.self.arn
  rule = aws_cloudwatch_event_rule.schedule_expression[each.key].id
}

resource "aws_cloudwatch_event_rule" "schedule_expression" {
  for_each = { for i in var.eventbridge_schedule_expression : i["name"] => i }

  description         = each.value["description"]
  is_enabled          = each.value["is_enabled"]
  name                = "lambda-${var.name}-${each.key}"
  schedule_expression = each.value["schedule_expression"]
  tags                = var.tags
}

##
## Event Pattern
##
resource "aws_lambda_permission" "event_pattern" {
  for_each = { for i in var.eventbridge_event_pattern : i["name"] => i }

  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.self.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.event_pattern[each.key].arn
  statement_id  = "AllowExecutionEventBridgeEventPattern"
}

resource "aws_cloudwatch_event_target" "event_pattern" {
  for_each = { for i in var.eventbridge_event_pattern : i["name"] => i }

  arn  = aws_lambda_function.self.arn
  rule = aws_cloudwatch_event_rule.event_pattern[each.key].id
}

resource "aws_cloudwatch_event_rule" "event_pattern" {
  for_each = { for i in var.eventbridge_event_pattern : i["name"] => i }

  description   = each.value["description"]
  event_pattern = each.value["event_pattern"]
  name          = "lambda-${var.name}-${each.key}"
  tags          = var.tags
}
