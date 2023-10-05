data "aws_caller_identity" "current" {}
data "aws_iam_account_alias" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}

##
## Outputs
##
output "account_alias" {
  value = data.aws_iam_account_alias.current.account_alias
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "partition" {
  value = data.aws_partition.current.id
}

output "region" {
  value = data.aws_region.current.name
}
