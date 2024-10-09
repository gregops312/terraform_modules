locals {
  container_definitions = [for i in var.container_definitions : i["container_definition"]]
  cluster_name          = trimprefix(data.aws_arn.self.resource, "cluster/")

  target_group_config       = [for i in var.container_definitions : i["target_group_config"] if i["target_group_config"] != null]
  target_group_health_check = [for i in var.container_definitions : i["target_group_health_check"] if i["target_group_health_check"] != null]

  # TODO: Come up with a better naming solution to address the 32 character limit of target group names, and still make
  #  the name informative that these target groups are for ecs services
  target_group_name = "${local.cluster_name}-${var.name}"

  service_target_group_config_list = [for i in var.container_definitions : i["service_target_group_config"] if i["service_target_group_config"] != null]

  service_target_group_config = length(local.service_target_group_config_list) == 1 ? {
    load_balancer = [
      merge(local.service_target_group_config_list[0], { target_group_arn = one(module.target_group[*].arn) })
    ]
  } : null

  secret_arns = flatten([for i in local.container_definitions : [
    for s in i.secrets : join(":", slice(split(":", s.valueFrom), 0, 7))
  ]])
}
