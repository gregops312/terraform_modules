resource "aws_iam_role_policy_attachment" "self" {
  for_each = local.policies

  role       = aws_iam_role.self.name
  policy_arn = aws_iam_policy.self[each.key].arn
}

resource "aws_iam_policy" "self" {
  for_each = local.policies

  name        = "${var.name}-${each.key}"
  description = each.value["description"]
  policy      = each.value["policy_json"]
  path        = "/lambda/"
  tags        = var.tags
}

data "aws_iam_policy_document" "default_logging" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:${module.metadata.partition}:logs:${module.metadata.region}:${module.metadata.account_id}:*"]
  }
}

resource "aws_iam_role" "self" {
  assume_role_policy = module.policies.lambda_assume
  description        = "Assume lambda"
  name               = "lambda-${var.name}"
  path               = "/lambda/"
  tags               = var.tags
}
