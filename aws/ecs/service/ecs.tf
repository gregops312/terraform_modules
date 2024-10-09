module "service" {
  source = "../../../atoms/ECS/ecs_service"

  cluster_arn     = var.permissions_and_networking.cluster_arn
  load_balancer   = local.service_target_group_config
  name            = var.name
  task_definition = module.task_definition.arn

  network_configuration = {
    security_groups = var.permissions_and_networking.security_groups
    subnets         = var.permissions_and_networking.subnets
  }
}

module "task_definition" {
  source = "../../../atoms/ECS/task_definition"

  container_definitions = local.container_definitions
  execution_role_arn    = module.execution_role.arn
  name                  = var.name
  task_role_arn         = one(module.task_role[*].arn)
}
