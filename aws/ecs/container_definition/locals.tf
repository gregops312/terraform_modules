locals {
  apps = keys(local.standard_app_port_mappings)

  default_logConfiguration = {
    options = {
      awslogs-group         = var.log_group_name
      awslogs-region        = module.data.region
      awslogs-stream-prefix = "ecs"
    }
  }

  image = "${var.image.name}:${var.image.version}"

  ##
  ## Port mappings and validation magic
  ##
  # Type is a magic var to handle standard app types for portMappings
  type = var.type == null ? "" : var.type
  portMappings = [for i in concat(var.portMappings, lookup(local.standard_app_port_mappings, local.type, [])) : {
    containerPort                  = i["containerPort"]
    hostPort                       = lookup(i, "hostPort", null) == null ? i["containerPort"] : i["hostPort"]
    protocol                       = i.protocol
    target_group_association       = lookup(i, "target_group_association", false)
    target_group_health_check_path = lookup(i, "target_group_health_check_path", null)
  }]

  # Create list of all container ports
  container_ports = [for i in local.portMappings : i["containerPort"]]
  host_ports      = [for i in local.portMappings : i["hostPort"]]

  # Check length of container_ports against a distinct version of container_ports
  # They should match if not duplicate ports were specified
  duplicate_container_ports = length(local.container_ports) != length(distinct(local.container_ports))
  duplicate_host_ports      = length(local.host_ports) != length(distinct(local.host_ports))
  target_group_config       = { for i in local.portMappings : i.containerPort => i.protocol if i.target_group_association }
  target_group_health_check = { for i in local.portMappings : i.containerPort => i.target_group_health_check_path if i.target_group_health_check_path != null }

  standard_app_port_mappings = {
    backend = [
      {
        # backend_app
        containerPort = 8081
        protocol      = "tcp"
      },
      {
        # backend_health
        containerPort                  = 8082
        target_group_health_check_path = "/actuator/health"
        protocol                       = "tcp"
      },
    ],
    envoy_sidecar = [
      {
        # ssl_sidecar_passthrough
        containerPort = 8078
        protocol      = "tcp"
      },
      {
        # ssl_sidecar_management
        containerPort            = 8079
        target_group_association = true
        protocol                 = "tcp"
      },
      {
        # ssl_sidecar_health
        containerPort = 8090
        protocol      = "tcp"
      }
    ],
    frontend = [
      {
        containerPort = 8080
        protocol      = "tcp"
      },
    ]
  }

  ##
  ## Secrets validation
  ##
  secret_names           = [for i in var.secrets : i.name]
  duplicate_secret_names = length(local.secret_names) != length(distinct(local.secret_names))
}
