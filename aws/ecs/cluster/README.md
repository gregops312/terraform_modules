<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudwatch_log_group"></a> [cloudwatch\_log\_group](#module\_cloudwatch\_log\_group) | ../../../atoms/CloudWatch/aws_cloudwatch_log_group | n/a |
| <a name="module_cluster"></a> [cluster](#module\_cluster) | ../../../atoms/ECS/aws_ecs_cluster | n/a |
| <a name="module_policies"></a> [policies](#module\_policies) | ../../../data/policies | n/a |
| <a name="module_sg_default"></a> [sg\_default](#module\_sg\_default) | ../../../atoms/VPC/aws_security_group | n/a |
| <a name="module_tags"></a> [tags](#module\_tags) | ../../../data/tags | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_vpc.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the cluster | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Temporary string ID of the VPC for security groups and the like. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN that identifies the cluster |
| <a name="output_cloudwatch_log_group"></a> [cloudwatch\_log\_group](#output\_cloudwatch\_log\_group) | n/a |
| <a name="output_id"></a> [id](#output\_id) | ARN that identifies the cluster |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_sg_default_id"></a> [sg\_default\_id](#output\_sg\_default\_id) | n/a |
<!-- END_TF_DOCS -->