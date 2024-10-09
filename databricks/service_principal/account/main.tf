resource "databricks_service_principal_secret" "self" {
  service_principal_id = databricks_service_principal.self.id
}

resource "databricks_group_member" "self" {
  group_id  = data.databricks_group.self.id
  member_id = databricks_service_principal.self.id
}

data "databricks_group" "self" {
  display_name = var.admin ? "databricks-admin" : "databricks-user"
}

resource "databricks_service_principal" "self" {
  active                     = var.active
  allow_cluster_create       = var.allow_cluster_create
  allow_instance_pool_create = var.allow_instance_pool_create
  databricks_sql_access      = var.databricks_sql_access
  disable_as_user_deletion   = false
  display_name               = var.name
  workspace_access           = var.workspace_access
}
