##
## Required Variables
##
variable "ssh_key" {
  description = "The name of the ssh key to use"
  type        = string
}

variable "tags" {
  description = "Map of tags"
  type        = map(any)
}

variable "vpc_cidr" {
  description = "The cidr notated VPC to use"
  type        = string
}
