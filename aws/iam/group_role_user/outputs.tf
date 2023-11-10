output "arn" {
  value = lookup({
    group = var.type == "group" ? one(aws_iam_group.self).arn : null
    role  = var.type == "role" ? one(aws_iam_role.self).arn : null
    user  = var.type == "user" ? one(aws_iam_user.self).arn : null
  }, var.type)
}
