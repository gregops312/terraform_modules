variable "name" {
  description = "Display name of service principal"
  type        = string
}

##
## Defaults
##
variable "active" {
  default     = true
  description = "Either service principal is active or not."
  type        = bool
}

variable "allow_cluster_create" {
  default     = false
  description = "Allow the service principal to have cluster create privileges."
  type        = bool
}

variable "allow_instance_pool_create" {
  default     = false
  description = "Allow the service principal to have instance pool create privileges."
  type        = bool
}

variable "databricks_sql_access" {
  default     = true
  description = "This is a field to allow the group to have access to Databricks SQL feature through databricks_sql_endpoint."
  type        = bool
}

variable "lifetime_seconds" {
  default     = 604800 # 1 week
  description = "The number of seconds before the token expires."
  type        = number
}

variable "workspace_access" {
  default     = false
  description = "This is a field to allow the group to have access to Databricks Workspace."
  type        = bool
}
