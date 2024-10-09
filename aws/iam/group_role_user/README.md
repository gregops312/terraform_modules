<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_group.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_iam_user_policy_attachment.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Friendly name of the [group, role, user]. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Key-value mapping of tags for the IAM [group, role, user]. | `map(any)` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | n/a | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Path to the role | `string` | `null` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | Policy objects that replace and streamline the downsides to inline policies. | <pre>list(object({<br/>    description = string<br/>    name        = string<br/>    policy      = string<br/>  }))</pre> | `[]` | no |
| <a name="input_policy_attachments"></a> [policy\_attachments](#input\_policy\_attachments) | A list of polcy ARNs to attach to [group, role, user]. | `list(string)` | `[]` | no |
| <a name="input_role"></a> [role](#input\_role) | Object, required when type == role: {assume\_role\_policy, description, max\_session\_duration} | <pre>object({<br/>    assume_role_policy    = string<br/>    description           = string<br/>    force_detach_policies = optional(bool, true)<br/>    max_session_duration  = optional(number, 3600)<br/>    permissions_boundary  = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_user"></a> [user](#input\_user) | User object, required when type == user. | <pre>object({<br/>    force_destroy        = optional(bool, false)<br/>    groups               = optional(list(string))<br/>    permissions_boundary = optional(string)<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
<!-- END_TF_DOCS -->
