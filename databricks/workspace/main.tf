resource "databricks_permissions" "self" {
  authorization = "tokens"

  access_control {
    group_name       = "users"
    permission_level = "CAN_USE"
  }
}

resource "databricks_instance_profile" "self" {
  instance_profile_arn = var.instance_profile_arn
}

data "databricks_group" "self" {
  for_each     = local.groups_role
  display_name = each.key
}

resource "databricks_group_role" "self" {
  for_each = local.groups_role
  group_id = data.databricks_group.self[each.key].id
  role     = databricks_instance_profile.self.id
}

resource "databricks_catalog" "self" {
  comment        = "DataLake isolated workspace catalog"
  isolation_mode = var.isolation_mode
  name           = "datalake-${var.env}"
  storage_root   = databricks_external_location.self.url
}

resource "databricks_external_location" "self" {
  comment         = "External location for UC root bucket"
  credential_name = databricks_storage_credential.self.id
  name            = "datalake-${var.env}"
  url             = "s3://${module.naming.s3_uc_bucket_name}"
  isolation_mode  = "ISOLATION_MODE_${var.isolation_mode}"
}

resource "databricks_storage_credential" "self" {
  name = var.env
  aws_iam_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/${module.naming.iam_role_uc_name}"
  }
  comment = "UC root bucket access role"
}

##
## Modules
##
module "naming" {
  source = "../naming"

  env = var.env
}

