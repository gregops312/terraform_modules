<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | ~> 1.21 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_databricks.account"></a> [databricks.account](#provider\_databricks.account) | ~> 1.21 |
| <a name="provider_databricks.workspace"></a> [databricks.workspace](#provider\_databricks.workspace) | ~> 1.21 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [databricks_obo_token.self](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/obo_token) | resource |
| [databricks_permission_assignment.self](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/permission_assignment) | resource |
| [databricks_service_principal.self](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/service_principal) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_active"></a> [active](#input\_active) | Either service principal is active or not. | `bool` | `true` | no |
| <a name="input_allow_cluster_create"></a> [allow\_cluster\_create](#input\_allow\_cluster\_create) | Allow the service principal to have cluster create privileges. | `bool` | `false` | no |
| <a name="input_allow_instance_pool_create"></a> [allow\_instance\_pool\_create](#input\_allow\_instance\_pool\_create) | Allow the service principal to have instance pool create privileges. | `bool` | `false` | no |
| <a name="input_databricks_sql_access"></a> [databricks\_sql\_access](#input\_databricks\_sql\_access) | This is a field to allow the group to have access to Databricks SQL feature through databricks\_sql\_endpoint. | `bool` | `true` | no |
| <a name="input_lifetime_seconds"></a> [lifetime\_seconds](#input\_lifetime\_seconds) | The number of seconds before the token expires. | `number` | `604800` | no |
| <a name="input_name"></a> [name](#input\_name) | Display name of service principal | `string` | n/a | yes |
| <a name="input_workspace_access"></a> [workspace\_access](#input\_workspace\_access) | This is a field to allow the group to have access to Databricks Workspace. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_obo_token"></a> [obo\_token](#output\_obo\_token) | n/a |
<!-- END_TF_DOCS -->