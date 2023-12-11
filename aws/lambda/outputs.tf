# output "arn" {
#   description = "Amazon Resource Name (ARN) identifying your Lambda Function"
#   value       = module.lambda_function.arn
# }

output "name" {
  description = "Name of the role"
  value       = aws_iam_role.self.name
}
