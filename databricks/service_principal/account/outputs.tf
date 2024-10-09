output "application_id" {
  value = databricks_service_principal.self.application_id
}

output "id" {
  value = databricks_service_principal.self.id
}

output "oauth_secret" {
  value = databricks_service_principal_secret.self.secret
}
