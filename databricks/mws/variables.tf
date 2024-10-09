locals {
  groups = {
    databricks-admin = {
      permissions = ["ADMIN"]
    }
    databricks-user = {
      permissions = ["USER"]
    }
  }
}

##
## Required Variables
##
variable "account_id" {
  description = "Databricks account ID"
  type        = string
}

variable "aws_region" {
  description = "The AWS region for resources/metastore"
  type        = string
}

variable "env" {
  description = "ENV name that drives naming of resources"
  type        = string
}

variable "role_arn" {
  description = "The Databricks PassRole arn to be used"
  type        = string
}

##
## AWS
##
variable "security_group_ids" {
  description = "The AWS security group IDs used by the Databricks network"
  type        = list(string)
}

variable "subnet_ids" {
  description = "The AWS subnet IDs used by the Databricks network"
  type        = list(string)
}

variable "vpc_id" {
  description = "The AWS VPC ID used by the Databricks network"
  type        = string
}
