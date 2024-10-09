<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_artifact_image_validator"></a> [artifact\_image\_validator](#module\_artifact\_image\_validator) | ../../error_handler | n/a |
| <a name="module_cd"></a> [cd](#module\_cd) | ../../../atoms/ECS/container_definition | n/a |
| <a name="module_data"></a> [data](#module\_data) | ../../../data | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_command"></a> [command](#input\_command) | n/a | `list(string)` | `null` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | CPU for container | `number` | `null` | no |
| <a name="input_entryPoint"></a> [entryPoint](#input\_entryPoint) | n/a | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | List of objects containing key=value pairs: {name, value} | <pre>list(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | `null` | no |
| <a name="input_essential"></a> [essential](#input\_essential) | n/a | `bool` | `null` | no |
| <a name="input_image"></a> [image](#input\_image) | Name and version of container image | <pre>object({<br/>    name    = string<br/>    version = string<br/>  })</pre> | n/a | yes |
| <a name="input_listener_rule"></a> [listener\_rule](#input\_listener\_rule) | Attributes for listener rule configuration | <pre>object({<br/>    host_headers = optional(list(string), null)<br/>    paths        = optional(list(string), null)<br/>  })</pre> | `null` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | (optional) describe your variable | `string` | n/a | yes |
| <a name="input_memoryReservation"></a> [memoryReservation](#input\_memoryReservation) | Soft memory limit, the defacto memory definition. | `number` | `null` | no |
| <a name="input_mountPoints"></a> [mountPoints](#input\_mountPoints) | n/a | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of container | `string` | n/a | yes |
| <a name="input_portMappings"></a> [portMappings](#input\_portMappings) | Object containing list(containerPort, hostPort, protocol, target\_group\_association, target\_group\_health\_check\_path), if only containerPort it will map same port to host | <pre>list(object({<br/>    containerPort                  = number<br/>    hostPort                       = optional(number, null)<br/>    protocol                       = optional(string, "tcp")<br/>    target_group_association       = optional(bool, false)<br/>    target_group_health_check_path = optional(string, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | List of object which uses AWS Secrets Manager secrets: {name, valueFrom} | <pre>list(object({<br/>    name      = string<br/>    valueFrom = string<br/>  }))</pre> | `[]` | no |
| <a name="input_type"></a> [type](#input\_type) | One of a list of standard app types to handle portMappings via magic | `string` | `null` | no |
| <a name="input_volumesFrom"></a> [volumesFrom](#input\_volumesFrom) | n/a | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_definition"></a> [container\_definition](#output\_container\_definition) | n/a |
| <a name="output_result"></a> [result](#output\_result) | n/a |
<!-- END_TF_DOCS -->