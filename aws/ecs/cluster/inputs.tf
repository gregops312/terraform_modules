locals {
  # TODO: make this magic, use tags too
  name         = "${var.name}-${module.tags.environment_name}"
  service_name = "ecs-${local.name}"
}

variable "name" {
  description = "Name of the cluster"
  type        = string
}

# TODO: remove this, by fixing tagging/naming
variable "vpc_id" {
  description = "Temporary string ID of the VPC for security groups and the like."
  type        = string
}
