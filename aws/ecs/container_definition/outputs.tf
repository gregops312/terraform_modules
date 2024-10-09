output "container_definition" {
  value = module.cd.result
}

output "result" {
  value = {
    container_definition = module.cd.result
    listener_rule        = merge(var.listener_rule, { name = var.name })
    target_group_health_check = length(local.target_group_health_check) == 1 ? {
      path = one(values(local.target_group_health_check))
      port = one(keys(local.target_group_health_check))
    } : null
    target_group_config = length(local.target_group_config) == 1 ? {
      port     = one(keys(local.target_group_config))
      protocol = one(values(local.target_group_config))
    } : null
    service_target_group_config = length(local.target_group_config) == 1 ? {
      container_name = var.name
      container_port = one(keys(local.target_group_config))
    } : null
  }

  precondition {
    condition = (
      !local.duplicate_container_ports &&
      !local.duplicate_host_ports
    )
    error_message = "You can not define duplicate ports for portMappings."
  }

  precondition {
    condition = (
      length(local.target_group_config) <= 1
    )
    error_message = "You can only <= 1 target_group_association mapped port, currently defined ports [${join(", ", keys(local.target_group_config))}]"
  }

  precondition {
    condition = (
      !local.duplicate_secret_names
    )
    error_message = "You can not define duplicate secret names, currently defined names [${join(", ", local.secret_names)}]"
  }

  precondition {
    condition = (
      length(local.target_group_health_check) <= 1
    )
    error_message = "You can only have 1 target_group_health_check port mapped, currently defined target_group_health_checks [${jsonencode(local.target_group_health_check)}]"
  }
}
