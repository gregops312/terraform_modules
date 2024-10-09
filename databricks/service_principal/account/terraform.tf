terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.21"
    }
  }

  required_version = ">= 1.5.5"
}
