locals {
  # Dynamically determine the type based on which input is defined.
  # Using the one() function ensures that only one is defined, and if more than one is defined, it will throw an error.
  # This dynamic type is then used to populate the value for the following generic object. Doing this helps keep the
  # module DRY and allows for easy expansion in the future.
  load_balancer_type = one(compact([
    var.application == null ? null : "application",
    var.gateway == null ? null : "gateway",
    var.network == null ? null : "network",
  ]))

  load_balancer = {
    application = var.application,
    gateway     = var.gateway,
    network     = var.network,
  }[local.load_balancer_type]
}

##
## ONLY ONE OF 'application', 'gateway', OR 'network' CAN BE USED AT A TIME
##

variable "application" {
  default     = null
  description = "Specifics for Application Load Balancer. Conflicts with 'network' and 'gateway' variables."
  type = object({
    connection_logs = optional(object({
      bucket  = string
      enabled = optional(bool, true)
      prefix  = optional(string)
    }))
    drop_invalid_header_fields                  = optional(bool, false)
    enable_http2                                = optional(bool, true)
    enable_tls_version_and_cipher_suite_headers = optional(bool, false)
    enable_xff_client_port                      = optional(bool, false)
    idle_timeout                                = optional(number, 60)
    name                                        = string
    preserve_host_header                        = optional(bool, false)
    xff_header_processing_mode                  = optional(string, "append")
  })
}

variable "gateway" {
  default     = null
  description = "Specifics for Gateway Load Balancer. Conflicts with 'application' and 'network' variables."
  type = object({
    enable_cross_zone_load_balancing = optional(bool, false)
    name                             = string
  })
}

variable "network" {
  default     = null
  description = "Specifics for Network Load Balancer. Conflicts with 'application' and 'gateway' variables."
  type = object({
    dns_record_client_routing_policy                             = optional(string, "any_availability_zone")
    enable_cross_zone_load_balancing                             = optional(bool, false)
    enforce_security_group_inbound_rules_on_private_link_traffic = optional(bool, null) # actual values that need to get passed are "on" or "off" but there is no default value
    name                                                         = string
  })
}

##
## Shared variables
##

variable "access_logs" {
  default     = null
  description = "Configuration for collecting access logs in S3. If not provided, access logs will not be collected."
  type = object({
    bucket  = string
    enabled = optional(bool, true)
    prefix  = optional(string)
  })
}

variable "client_keep_alive" {
  default     = 3600
  description = "Client keep alive value in seconds. The valid range is 60-604800 seconds."
  type        = number
}

variable "customer_owned_ipv4_pool" {
  default     = null
  description = "ID of the customer owned ipv4 pool to use for this load balancer."
  type        = string
}

variable "desync_mitigation_mode" {
  default     = "defensive"
  description = "How the load balancer handles requests that might pose a security risk to an application due to HTTP desync. Valid values are 'monitor', 'defensive' (default), 'strictest'."
  type        = string
}

variable "enable_deletion_protection" {
  default     = false
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer."
  type        = bool
}

variable "enable_waf_fail_open" {
  default     = false
  description = "Whether to allow a WAF-enabled load balancer to route requests to targets if it is unable to forward the request to AWS WAF."
  type        = bool
}

variable "internal" {
  default     = false
  description = "If true, the LB will be internal."
  type        = bool
}

variable "ip_address_type" {
  default     = "ipv4"
  description = "Type of IP addresses used by the subnets for your load balancer. The possible values are 'ipv4' and 'dualstack'."
  type        = string
}

variable "security_groups" {
  default     = null
  description = "List of security group IDs to assign to the LB. For load balancers of type 'network' security groups cannot be added if none are currently present, and cannot be removed once added. If either of these conditions are met, this will force a recreation of the resource."
  type        = set(string)
}

variable "subnet_mapping" {
  default     = []
  description = "A list of subnet mapping objects to use for the LB. For Load Balancers of type 'network' subnet mappings can only be added. Conflicts with 'subnets' variable."
  type = list(object({
    allocation_id        = optional(string)
    subnet_id            = string
    private_ipv4_address = optional(string)
  }))
}

variable "subnets" {
  default     = null
  description = "List of subnet IDs to attach to the LB. Subnets cannot be in the same availability zone. For load balancers of type 'network' subnets can only be added, and cannot be removed once added, doing so will force a recreation of the resource. Conflicts with 'subnet_mapping' variable."
  type        = set(string)
}

variable "tags" {
  default     = {}
  description = "A map of tags to add to all resources."
  type        = map(string)
}
