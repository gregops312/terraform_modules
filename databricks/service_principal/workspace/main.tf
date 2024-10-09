resource "databricks_obo_token" "self" {
  provider = databricks.workspace

  application_id   = databricks_service_principal.self.application_id
  comment          = "PAT on behalf of ${databricks_service_principal.self.display_name}"
  lifetime_seconds = var.lifetime_seconds
}

resource "databricks_permission_assignment" "self" {
  provider = databricks.workspace

  principal_id = databricks_service_principal.self.id
  permissions  = ["USER"]
}

resource "databricks_service_principal" "self" {
  provider = databricks.account

  active                     = var.active
  allow_cluster_create       = var.allow_cluster_create
  allow_instance_pool_create = var.allow_instance_pool_create
  databricks_sql_access      = var.databricks_sql_access
  disable_as_user_deletion   = false
  display_name               = var.name
  workspace_access           = var.workspace_access
}
