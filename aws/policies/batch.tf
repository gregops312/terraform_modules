output "batch_assume" {
  value = data.aws_iam_policy_document.batch_assume.json
}

data "aws_iam_policy_document" "batch_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["batch.amazonaws.com"]
    }
  }
}
