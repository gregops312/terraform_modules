locals {
  default_policies = [
    {
      description = "Default logging policy"
      name        = "${var.name}-default-logging"
      policy_json = data.aws_iam_policy_document.default_logging.json
    }
  ]
  policies = { for i in concat(local.default_policies, var.policies) : i["name"] => i }
}
