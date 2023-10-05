output "mfa" {
  value = data.aws_iam_policy_document.mfa.json
}

# https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage-mfa-only.html
data "aws_iam_policy_document" "mfa" {
  statement {
    sid       = "AllowViewAccountInfo"
    effect    = "Allow"
    actions   = ["iam:ListVirtualMFADevices"]
    resources = ["*"]
  }
  statement {
    sid       = "AllowManageOwnVirtualMFADevice"
    effect    = "Allow"
    actions   = ["iam:CreateVirtualMFADevice"]
    resources = ["arn:aws:iam::*:mfa/*"]
  }
  statement {
    sid    = "AllowUserManageOwnMFA"
    effect = "Allow"
    actions = [
      "iam:CreateAccessKey",
      "iam:DeactivateMFADevice",
      "iam:DeleteAccessKey",
      "iam:EnableMFADevice",
      "iam:GetAccessKeyLastUsed",
      "iam:GetAccountSummary",
      "iam:GetUser",
      "iam:ListAccessKeys",
      "iam:ListMFADevices",
      "iam:ListUserTags",
      "iam:ResyncMFADevice",
      "iam:UpdateAccessKey",
    ]
    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
  statement {
    sid    = "DenyAllExceptListedIfNoMFA"
    effect = "Deny"
    not_actions = [
      "iam:ChangePassword",
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetUser",
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
      "sts:GetSessionToken",
    ]
    resources = ["*"]
    condition {
      # TODO: Enable MFA for all access
      # This is what the policy should be to require MFA on both CLI and Console access
      # test     = "BoolIfExists"
      # This is what we're used to, MFA for Console, no-MFA for CLI
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["false"]
    }
  }
}
