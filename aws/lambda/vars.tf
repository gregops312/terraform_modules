variable "filename" {
  description = "Path to the function's deployment package within the local filesystem"
  type        = string
}

variable "name" {
  description = "Name for sources in the molecule"
  type        = string
}

variable "runtime" {
  description = "Identifier of the function's runtime"
  type        = string
  default     = "python3.9"
}

variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
}

##
## Defaults
##
variable "cloudwatch" {
  default     = {}
  description = "Cloudwatch log group config"
  type = object({
    kms_key_id        = optional(string, null)
    retention_in_days = optional(number, 30)
  })
}

variable "environment" {
  default     = null
  description = "Environment variables config"
}

variable "handler" {
  default     = "lambda_handler"
  description = "Function entrypoint in your code"
  type        = string
}

variable "layers" {
  default     = null
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function"
  type        = list(string)
}

variable "policies" {
  default     = []
  description = "List of policy objects containing: descrition, name, and policy json."
  type = list(object({
    description = string
    name        = string
    policy_json = string
  }))
}

variable "timeout" {
  default     = 30
  description = "Time in seconds until function stopped"
  type        = number
}

variable "vpc_config" {
  default     = null
  description = "For network connectivity to AWS resources in a VPC, specify a list of security groups and subnets in the VPC."
}

##
## Trigger variables
##
variable "eventbridge_event_pattern" {
  default     = []
  description = "Event patterns are complex and may need a CloudTrail trail to work"
  type = list(object({
    description   = string
    event_pattern = string
    name          = string
  }))
}

variable "eventbridge_schedule_expression" {
  default     = []
  description = "Expressions either are cron or rate based, see AWS docs for more"
  type = list(object({
    description         = string
    is_enabled          = optional(bool, true)
    name                = string
    schedule_expression = string
  }))
}
