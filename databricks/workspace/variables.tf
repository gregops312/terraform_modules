locals {
  groups_role = toset(["databricks-admin", "databricks-user"])
}

##
## Required Variables
##
variable "aws_account_id" {
  description = "AWS account ID for resource role assignments"
  type        = string
}

variable "env" {
  description = "ENV name that drives naming of resources"
  type        = string
}

variable "instance_profile_arn" {
  description = "AWS instance profile ARN for Databricks to reference"
  type        = string
}

##
## Default Variables
##
variable "isolation_mode" {
  default     = "ISOLATED"
  description = "Whether the catalog is accessible from all workspaces or a specific set of workspaces."
  type        = string
}
