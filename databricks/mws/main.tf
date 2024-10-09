resource "databricks_mws_permission_assignment" "self" {
  for_each     = local.groups
  principal_id = data.databricks_group.self[each.key].id
  permissions  = each.value["permissions"]
  workspace_id = databricks_mws_workspaces.self.workspace_id

  depends_on = [time_sleep.wait]
}

# The mws_permssions_assignment was failing prior to adding this
# Pretty sure DBX uses Azure on the backend.
# We know all to well that Azure has an "eventual consistency API design with no in-process read API!"
resource "time_sleep" "wait" {
  depends_on      = [data.databricks_metastore.self]
  create_duration = "60s"
}

data "databricks_group" "self" {
  for_each     = local.groups
  display_name = each.key
}

resource "databricks_metastore_assignment" "self" {
  metastore_id         = data.databricks_metastore.self.id
  workspace_id         = databricks_mws_workspaces.self.workspace_id
  default_catalog_name = null
}

resource "databricks_mws_workspaces" "self" {
  account_id               = var.account_id
  aws_region               = var.aws_region
  credentials_id           = databricks_mws_credentials.self.credentials_id
  network_id               = databricks_mws_networks.self.network_id
  storage_configuration_id = databricks_mws_storage_configurations.self.storage_configuration_id
  workspace_name           = var.env
}

resource "databricks_mws_credentials" "self" {
  credentials_name = var.env
  role_arn         = var.role_arn
}

resource "databricks_mws_networks" "self" {
  account_id         = var.account_id
  network_name       = var.env
  vpc_id             = var.vpc_id
  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids

  lifecycle {
    create_before_destroy = true
  }
}

resource "databricks_mws_storage_configurations" "self" {
  account_id                 = var.account_id
  bucket_name                = module.naming.s3_workspace_bucket_name
  storage_configuration_name = var.env
}

##
## Modules
##
module "naming" {
  source = "../naming"

  env = var.env
}
