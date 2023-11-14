<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0, <= 1.5.5 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | A valid string JSON of container definitions. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cpu"></a> [cpu](#output\_cpu) | The calculated number of CPU units based on the values defined in the container definitions. |
| <a name="output_memory"></a> [memory](#output\_memory) | The calculated memory based on the values defined in the container definitions. |
<!-- END_TF_DOCS -->