data "aws_vpc" "self" {
  id = var.vpc_id
}

module "policies" {
  source = "../../../data/policies"
}

module "tags" {
  source = "../../../data/tags"
}
