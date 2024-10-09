!***You must manually assign Account Admin to a Service Principal**

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

No modules.

## Resources

| Name | Type |
|------|------|
| [databricks_group_member.self](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group_member) | resource |
| [databricks_service_principal.self](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/service_principal) | resource |
| [databricks_service_principal_secret.self](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/service_principal_secret) | resource |
| [databricks_group.self](https://registry.terraform.io/providers/databricks/databricks/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_active"></a> [active](#input\_active) | Either service principal is active or not. | `bool` | `true` | no |
| <a name="input_admin"></a> [admin](#input\_admin) | Add Service Principal to admin group | `bool` | `false` | no |
| <a name="input_allow_cluster_create"></a> [allow\_cluster\_create](#input\_allow\_cluster\_create) | Allow the service principal to have cluster create privileges. | `bool` | `false` | no |
| <a name="input_allow_instance_pool_create"></a> [allow\_instance\_pool\_create](#input\_allow\_instance\_pool\_create) | Allow the service principal to have instance pool create privileges. | `bool` | `false` | no |
| <a name="input_databricks_sql_access"></a> [databricks\_sql\_access](#input\_databricks\_sql\_access) | This is a field to allow the group to have access to Databricks SQL feature through databricks\_sql\_endpoint. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Display name of service principal | `string` | n/a | yes |
| <a name="input_workspace_access"></a> [workspace\_access](#input\_workspace\_access) | This is a field to allow the group to have access to Databricks Workspace. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_id"></a> [application\_id](#output\_application\_id) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_oauth_secret"></a> [oauth\_secret](#output\_oauth\_secret) | n/a |
<!-- END_TF_DOCS -->
