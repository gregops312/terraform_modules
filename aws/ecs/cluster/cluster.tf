module "cluster" {
  source = "../../../atoms/ECS/aws_ecs_cluster"

  name = local.name
}
