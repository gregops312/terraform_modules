locals {
  policy_attachments = concat(var.policy_attachments, [for i in aws_iam_policy.self : i.arn])
}

##
## Group
##
resource "aws_iam_group_policy_attachment" "self" {
  count = var.type == "group" ? length(local.policy_attachments) : 0

  group      = one(aws_iam_group.self).name
  policy_arn = local.policy_attachments[count.index]
}

resource "aws_iam_group" "self" {
  count = var.type == "group" ? 1 : 0

  name = var.name
  path = var.path
}

##
## Role
##
resource "aws_iam_role_policy_attachment" "self" {
  count = var.type == "role" ? length(local.policy_attachments) : 0

  policy_arn = local.policy_attachments[count.index]
  role       = one(aws_iam_role.self).name
}

resource "aws_iam_role" "self" {
  count = var.type == "role" ? 1 : 0

  assume_role_policy    = var.role.assume_role_policy
  description           = var.role.description
  force_detach_policies = var.role.force_detach_policies
  max_session_duration  = var.role.max_session_duration
  name                  = var.name
  path                  = var.path
  permissions_boundary  = var.role.permissions_boundary
  tags                  = var.tags
}

##
## User
##
resource "aws_iam_user_group_membership" "self" {
  count = (var.type == "user" && var.user.groups != null) ? 1 : 0

  user   = one(aws_iam_user.self).name
  groups = var.user.groups
}

resource "aws_iam_user" "self" {
  count = var.type == "user" ? 1 : 0

  force_destroy        = var.user.force_destroy
  name                 = var.name
  path                 = var.path
  permissions_boundary = var.user.permissions_boundary
  tags                 = var.tags
}

##
## Policies
##
resource "aws_iam_policy" "self" {
  for_each = { for i in var.policies : i["name"] => i }

  description = each.value["description"]
  name        = each.key
  path        = var.path
  policy      = each.value["policy"]
  tags        = var.tags
}
