<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_metadata"></a> [metadata](#module\_metadata) | ../metadata | n/a |
| <a name="module_policies"></a> [policies](#module\_policies) | ../policies | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.event_pattern](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_rule.schedule_expression](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.event_pattern](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_event_target.schedule_expression](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.event_pattern](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.schedule_expression](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_iam_policy_document.default_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_filename"></a> [filename](#input\_filename) | Path to the function's deployment package within the local filesystem | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name for sources in the molecule | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to resources | `map(string)` | n/a | yes |
| <a name="input_cloudwatch"></a> [cloudwatch](#input\_cloudwatch) | Cloudwatch log group config | <pre>object({<br>    kms_key_id        = optional(string, null)<br>    retention_in_days = optional(number, 30)<br>  })</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment variables config | `any` | `null` | no |
| <a name="input_eventbridge_event_pattern"></a> [eventbridge\_event\_pattern](#input\_eventbridge\_event\_pattern) | Event patterns are complex and may need a CloudTrail trail to work | <pre>list(object({<br>    description   = string<br>    event_pattern = string<br>    name          = string<br>  }))</pre> | `[]` | no |
| <a name="input_eventbridge_schedule_expression"></a> [eventbridge\_schedule\_expression](#input\_eventbridge\_schedule\_expression) | Expressions either are cron or rate based, see AWS docs for more | <pre>list(object({<br>    description         = string<br>    is_enabled          = optional(bool, true)<br>    name                = string<br>    schedule_expression = string<br>  }))</pre> | `[]` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | Function entrypoint in your code | `string` | `"lambda_handler"` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function | `list(string)` | `null` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | List of policy objects containing: descrition, name, and policy json. | <pre>list(object({<br>    description = string<br>    name        = string<br>    policy_json = string<br>  }))</pre> | `[]` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Identifier of the function's runtime | `string` | `"python3.9"` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds until function stopped | `number` | `30` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | For network connectivity to AWS resources in a VPC, specify a list of security groups and subnets in the VPC. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | Name of the role |
<!-- END_TF_DOCS -->
