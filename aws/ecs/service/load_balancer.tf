module "target_group" {
  source = "../../../atoms/ELB_v2/target_group"

  count = length(local.target_group_config) == 1 ? 1 : 0

  health_check = one(local.target_group_health_check)

  ip = {
    name     = local.target_group_name
    port     = one(local.target_group_config[*].port)
    protocol = one(local.target_group_config[*].protocol)

    # TODO: unfuck this, once tagging is unfucked
    vpc_id = var.permissions_and_networking.vpc_id
  }
}
