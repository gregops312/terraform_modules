<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | ~> 1.21 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | ~> 1.21 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_naming"></a> [naming](#module\_naming) | ../naming | n/a |

## Resources

| Name | Type |
|------|------|
| [databricks_catalog.self](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/catalog) | resource |
| [databricks_external_location.self](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/external_location) | resource |
| [databricks_group_role.self](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_role) | resource |
| [databricks_instance_profile.self](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/instance_profile) | resource |
| [databricks_permissions.self](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/permissions) | resource |
| [databricks_storage_credential.self](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/storage_credential) | resource |
| [databricks_group.self](https://registry.terraform.io/providers/databricks/databricks/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | AWS account ID for resource role assignments | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | ENV name that drives naming of resources | `string` | n/a | yes |
| <a name="input_instance_profile_arn"></a> [instance\_profile\_arn](#input\_instance\_profile\_arn) | AWS instance profile ARN for Databricks to reference | `string` | n/a | yes |
| <a name="input_isolation_mode"></a> [isolation\_mode](#input\_isolation\_mode) | Whether the catalog is accessible from all workspaces or a specific set of workspaces. | `string` | `"ISOLATED"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_profile_arn"></a> [instance\_profile\_arn](#output\_instance\_profile\_arn) | n/a |
<!-- END_TF_DOCS -->