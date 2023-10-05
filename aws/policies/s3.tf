output "s3_assume" {
  value = data.aws_iam_policy_document.s3_assume.json
}

data "aws_iam_policy_document" "s3_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
  }
}
