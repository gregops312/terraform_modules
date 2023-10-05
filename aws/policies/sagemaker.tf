output "sagemaker_assume" {
  value = data.aws_iam_policy_document.sagemaker_assume.json
}

output "sagemaker_ssm_assume" {
  value = data.aws_iam_policy_document.sagemaker_ssm_assume.json
}

data "aws_iam_policy_document" "sagemaker_assume" {
  statement {
    sid = "AssumeSageMaker"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "sagemaker_ssm_assume" {
  statement {
    sid = "AssumeSageMaker"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }

  statement {
    sid = "AssumeSSM"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }
  }
}
