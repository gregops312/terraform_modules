output "glue_assume" {
  value = data.aws_iam_policy_document.glue_assume.json
}

data "aws_iam_policy_document" "glue_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}
