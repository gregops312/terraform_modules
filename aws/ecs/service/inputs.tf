variable "container_definitions" {
  description = "MUST be list of objects coming from molecule container_definition"
}

variable "name" {
  description = "Base name of the cluster and base needs"
  type        = string
}

variable "permissions_and_networking" {
  description = "Administrative configs for service defining permissions and networking"
  type = object({
    cluster_arn     = string
    security_groups = list(string)

    # TODO: This should be looked up by default, but our tagging and filtering abilities are so poor.
    # This is due to the horribleness of "common/fleet" they have no literal difference in tagging, including in their environment_name name.
    subnets = list(string)
    vpc_id  = string
  })
}

##
## Defaults
##
variable "iam" {
  default     = null
  description = "object contain list of policy_attachments or polices to add to IAM Role for service"
  type = object({
    policy_attachments = optional(list(string), [])
    policies = optional(list(object({
      description = string
      name        = string
      policy      = string
    })), [])
  })
}
