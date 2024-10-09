module "cd" {
  source = "../../../atoms/ECS/container_definition"

  command           = var.command
  cpu               = var.cpu
  entryPoint        = var.entryPoint
  environment       = var.environment
  essential         = var.essential
  image             = local.image
  logConfiguration  = local.default_logConfiguration
  memoryReservation = var.memoryReservation
  mountPoints       = var.mountPoints
  name              = var.name
  portMappings      = local.portMappings
  secrets           = var.secrets
  volumesFrom       = var.volumesFrom
}
