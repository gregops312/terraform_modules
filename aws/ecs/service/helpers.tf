data "aws_arn" "self" {
  arn = var.permissions_and_networking.cluster_arn
}

data "aws_iam_policy" "AmazonECSTaskExecutionRolePolicy" {
  name = "AmazonECSTaskExecutionRolePolicy"
}

module "metadata" {
  source = "../../../data/metadata"
}

module "policies" {
  source = "../../../data/policies"
}

module "tags" {
  source = "../../../data/tags"
}
