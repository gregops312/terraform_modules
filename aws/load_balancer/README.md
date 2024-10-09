<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs"></a> [access\_logs](#input\_access\_logs) | Configuration for collecting access logs in S3. If not provided, access logs will not be collected. | <pre>object({<br/>    bucket  = string<br/>    enabled = optional(bool, true)<br/>    prefix  = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_application"></a> [application](#input\_application) | Specifics for Application Load Balancer. Conflicts with 'network' and 'gateway' variables. | <pre>object({<br/>    connection_logs = optional(object({<br/>      bucket  = string<br/>      enabled = optional(bool, true)<br/>      prefix  = optional(string)<br/>    }))<br/>    drop_invalid_header_fields                  = optional(bool, false)<br/>    enable_http2                                = optional(bool, true)<br/>    enable_tls_version_and_cipher_suite_headers = optional(bool, false)<br/>    enable_xff_client_port                      = optional(bool, false)<br/>    idle_timeout                                = optional(number, 60)<br/>    name                                        = string<br/>    preserve_host_header                        = optional(bool, false)<br/>    xff_header_processing_mode                  = optional(string, "append")<br/>  })</pre> | `null` | no |
| <a name="input_client_keep_alive"></a> [client\_keep\_alive](#input\_client\_keep\_alive) | Client keep alive value in seconds. The valid range is 60-604800 seconds. | `number` | `3600` | no |
| <a name="input_customer_owned_ipv4_pool"></a> [customer\_owned\_ipv4\_pool](#input\_customer\_owned\_ipv4\_pool) | ID of the customer owned ipv4 pool to use for this load balancer. | `string` | `null` | no |
| <a name="input_desync_mitigation_mode"></a> [desync\_mitigation\_mode](#input\_desync\_mitigation\_mode) | How the load balancer handles requests that might pose a security risk to an application due to HTTP desync. Valid values are 'monitor', 'defensive' (default), 'strictest'. | `string` | `"defensive"` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. | `bool` | `false` | no |
| <a name="input_enable_waf_fail_open"></a> [enable\_waf\_fail\_open](#input\_enable\_waf\_fail\_open) | Whether to allow a WAF-enabled load balancer to route requests to targets if it is unable to forward the request to AWS WAF. | `bool` | `false` | no |
| <a name="input_gateway"></a> [gateway](#input\_gateway) | Specifics for Gateway Load Balancer. Conflicts with 'application' and 'network' variables. | <pre>object({<br/>    enable_cross_zone_load_balancing = optional(bool, false)<br/>    name                             = string<br/>  })</pre> | `null` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | If true, the LB will be internal. | `bool` | `false` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | Type of IP addresses used by the subnets for your load balancer. The possible values are 'ipv4' and 'dualstack'. | `string` | `"ipv4"` | no |
| <a name="input_network"></a> [network](#input\_network) | Specifics for Network Load Balancer. Conflicts with 'application' and 'gateway' variables. | <pre>object({<br/>    dns_record_client_routing_policy                             = optional(string, "any_availability_zone")<br/>    enable_cross_zone_load_balancing                             = optional(bool, false)<br/>    enforce_security_group_inbound_rules_on_private_link_traffic = optional(bool, null) # actual values that need to get passed are "on" or "off" but there is no default value<br/>    name                                                         = string<br/>  })</pre> | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | List of security group IDs to assign to the LB. For load balancers of type 'network' security groups cannot be added if none are currently present, and cannot be removed once added. If either of these conditions are met, this will force a recreation of the resource. | `set(string)` | `null` | no |
| <a name="input_subnet_mapping"></a> [subnet\_mapping](#input\_subnet\_mapping) | A list of subnet mapping objects to use for the LB. For Load Balancers of type 'network' subnet mappings can only be added. Conflicts with 'subnets' variable. | <pre>list(object({<br/>    allocation_id        = optional(string)<br/>    subnet_id            = string<br/>    private_ipv4_address = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnet IDs to attach to the LB. Subnets cannot be in the same availability zone. For load balancers of type 'network' subnets can only be added, and cannot be removed once added, doing so will force a recreation of the resource. Conflicts with 'subnet\_mapping' variable. | `set(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
<!-- END_TF_DOCS -->