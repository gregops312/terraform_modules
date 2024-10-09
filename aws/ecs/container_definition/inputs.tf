variable "image" {
  description = "Name and version of container image"
  type = object({
    name    = string
    version = string
  })
}

variable "log_group_name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "name" {
  description = "Name of container"
  type        = string
}

##
## Defaults
##

variable "command" {
  default = null
  type    = list(string)
}

variable "cpu" {
  default     = null
  description = "CPU for container"
  type        = number
}

variable "entryPoint" {
  default = []
  type    = list(string)
}

variable "environment" {
  default     = null
  description = "List of objects containing key=value pairs: {name, value}"
  type = list(object({
    name  = string
    value = string
  }))
}

variable "essential" {
  default = null
  type    = bool
}

variable "listener_rule" {
  default     = null
  description = "Attributes for listener rule configuration"
  type = object({
    host_headers = optional(list(string), null)
    paths        = optional(list(string), null)
  })
}

variable "memoryReservation" {
  default     = null
  description = "Soft memory limit, the defacto memory definition."
  type        = number
}

variable "mountPoints" {
  default = []
  type    = list(string)
}

variable "portMappings" {
  default     = []
  description = "Object containing list(containerPort, hostPort, protocol, target_group_association, target_group_health_check_path), if only containerPort it will map same port to host"
  type = list(object({
    containerPort                  = number
    hostPort                       = optional(number, null)
    protocol                       = optional(string, "tcp")
    target_group_association       = optional(bool, false)
    target_group_health_check_path = optional(string, null)
  }))
}

variable "secrets" {
  default     = []
  description = "List of object which uses AWS Secrets Manager secrets: {name, valueFrom}"
  type = list(object({
    name      = string
    valueFrom = string
  }))
}

variable "type" {
  default     = null
  description = "One of a list of standard app types to handle portMappings via magic"
  type        = string

  validation {
    condition     = try(contains(local.apps, var.type), true)
    error_message = "If defined must be one of ${join(", ", local.apps)}"
  }
}

variable "volumesFrom" {
  default = []
  type    = list(string)
}
