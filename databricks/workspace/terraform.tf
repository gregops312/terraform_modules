terraform {
  required_providers {
    databricks = {
      configuration_aliases = [databricks.account]
      source                = "databricks/databricks"
      version               = "~> 1.21"
    }
  }

  required_version = ">= 1.5.5"
}
