##
## Variables
##
variable "env" {
  description = "The env to build resource names"
  type        = string
}

##
## Locals
##
locals {
  aws_base_name = "${local.service}-${var.env}"
  s3_base_name  = "uptake-${local.aws_base_name}"
  service       = "dbx"
}

##
## Outputs
##
output "aws_base_name" {
  value = local.aws_base_name
}

output "iam_role_uc_name" {
  value = "${local.aws_base_name}-unity-catalog"
}

output "s3_base_name" {
  value = local.s3_base_name
}

output "s3_uc_bucket_name" {
  value = "${local.s3_base_name}-catalog-root"
}

output "s3_workspace_bucket_name" {
  value = "${local.s3_base_name}-workspace-root"
}
