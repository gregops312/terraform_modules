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
| <a name="module_execution_role"></a> [execution\_role](#module\_execution\_role) | ../../iam/group_role_user | n/a |
| <a name="module_metadata"></a> [metadata](#module\_metadata) | ../../../data/metadata | n/a |
| <a name="module_policies"></a> [policies](#module\_policies) | ../../../data/policies | n/a |
| <a name="module_service"></a> [service](#module\_service) | ../../../atoms/ECS/ecs_service | n/a |
| <a name="module_tags"></a> [tags](#module\_tags) | ../../../data/tags | n/a |
| <a name="module_target_group"></a> [target\_group](#module\_target\_group) | ../../../atoms/ELB_v2/target_group | n/a |
| <a name="module_task_definition"></a> [task\_definition](#module\_task\_definition) | ../../../atoms/ECS/task_definition | n/a |
| <a name="module_task_role"></a> [task\_role](#module\_task\_role) | ../../iam/group_role_user | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_arn.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |
| [aws_iam_policy.AmazonECSTaskExecutionRolePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.secrets_manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | MUST be list of objects coming from molecule container\_definition | `any` | n/a | yes |
| <a name="input_iam"></a> [iam](#input\_iam) | object contain list of policy\_attachments or polices to add to IAM Role for service | <pre>object({<br/>    policy_attachments = optional(list(string), [])<br/>    policies = optional(list(object({<br/>      description = string<br/>      name        = string<br/>      policy      = string<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Base name of the cluster and base needs | `string` | n/a | yes |
| <a name="input_permissions_and_networking"></a> [permissions\_and\_networking](#input\_permissions\_and\_networking) | Administrative configs for service defining permissions and networking | <pre>object({<br/>    cluster_arn     = string<br/>    security_groups = list(string)<br/><br/>    # TODO: This should be looked up by default, but our tagging and filtering abilities are so poor.<br/>    # This is due to the horribleness of "common/fleet" they have no literal difference in tagging, including in their environment_name name.<br/>    subnets = list(string)<br/>    vpc_id  = string<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | n/a |
<!-- END_TF_DOCS -->
