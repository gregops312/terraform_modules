data "databricks_metastore" "self" {
  name = "uptake-${var.aws_region}"
}
