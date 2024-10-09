variable "name" {
  description = "Friendly name of the [group, role, user]."
  type        = string
}

variable "tags" {
  description = "Key-value mapping of tags for the IAM [group, role, user]."
  type        = map(any)
}

variable "type" {
  description = "The type of the resource to implement"
  type        = string
  validation {
    condition     = contains(["group", "role", "user"], var.type)
    error_message = "Must be one of [group, role, user]."
  }
}

##
## Default
##
variable "role" {
  default     = null
  description = "Object, required when type == role: {assume_role_policy, description, max_session_duration}"
  type = object({
    assume_role_policy    = string
    description           = string
    force_detach_policies = optional(bool, true)
    max_session_duration  = optional(number, 3600)
    permissions_boundary  = optional(string)
  })
}

variable "path" {
  default     = null
  description = "Path to the role"
  type        = string

  validation {
    # TODO: In terraform 1.3 startswith() & endswith() were introduced
    condition = (
      var.path == null ||
      (can(regex("^/", var.path)) && can(regex("/$", var.path)))
    )
    error_message = "The path must begin and end with /."
  }
}

variable "policies" {
  default     = []
  description = "Policy objects that replace and streamline the downsides to inline policies."
  type = list(object({
    description = string
    name        = string
    policy      = string
  }))
}

variable "policy_attachments" {
  default     = []
  description = "A list of polcy ARNs to attach to [group, role, user]."
  type        = list(string)
}

variable "user" {
  default     = {}
  description = "User object, required when type == user."
  type = object({
    force_destroy        = optional(bool, false)
    groups               = optional(list(string))
    permissions_boundary = optional(string)
  })
}
