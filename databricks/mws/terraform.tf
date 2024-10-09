terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.21"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.11"
    }
  }

  required_version = ">= 1.5.5"
}
