locals {
  default_rules = [
    {
      id         = "Immediate transition to Intelligent-Tiering"
      status     = "Enabled"
      expiration = null
      transition = {
        days          = 0
        storage_class = "INTELLIGENT_TIERING"
      },
    }
  ]

  lifecycle_rules = concat(local.default_rules, var.lifecycle_configuration == null ? [] : var.lifecycle_configuration)
}

##
## Required Variables
##
variable "name" {
  description = "Name of S3 bucket"
  type        = string
}

variable "tags" {
  description = "Map of key/value"
  type        = map(string)
}

##
## Default Variables
##
variable "lifecycle_configuration" {
  default     = null
  description = "List of rule objects defining object lifecycle. When many buckets are used in conjunction, all buckets will get the configuration defined."
  type = list(object({
    id     = string
    status = string
    expiration = optional(object({
      days = number
    }))
    transition = optional(object({
      days          = number
      storage_class = string
    }))
  }))
}

variable "object_ownership" {
  default = "BucketOwnerEnforced"
  type    = string
}

variable "policy" {
  default     = null
  description = "JSON policy to apply to the bucket"
  type        = string
}

variable "public_access_block" {
  default = {}
  type = object({
    block_public_acls       = optional(bool, true)
    block_public_policy     = optional(bool, true)
    ignore_public_acls      = optional(bool, true)
    restrict_public_buckets = optional(bool, true)
  })
}

variable "server_side_encryption" {
  default = {}
  type = object({
    kms_master_key_id = optional(string)
    sse_algorithm     = optional(string, "aws:kms")
  })
}

variable "versioning" {
  default = "Disabled"
  type    = string
}
