resource "aws_lb" "self" {
  client_keep_alive          = var.client_keep_alive
  customer_owned_ipv4_pool   = var.customer_owned_ipv4_pool
  desync_mitigation_mode     = var.desync_mitigation_mode
  enable_deletion_protection = var.enable_deletion_protection
  enable_waf_fail_open       = var.enable_waf_fail_open
  internal                   = var.internal
  ip_address_type            = var.ip_address_type
  load_balancer_type         = local.load_balancer_type
  name                       = local.load_balancer["name"]
  security_groups            = var.security_groups
  subnets                    = var.subnets
  tags                       = var.tags

  dynamic "access_logs" {
    for_each = var.access_logs == null ? [] : [var.access_logs]
    iterator = i
    content {
      bucket  = i.value["bucket"]
      enabled = i.value["enabled"]
      prefix  = i.value["prefix"]
    }
  }

  dynamic "subnet_mapping" {
    for_each = var.subnet_mapping[*]
    iterator = i
    content {
      allocation_id        = i.value["allocation_id"]
      subnet_id            = i.value["subnet_id"]
      private_ipv4_address = i.value["private_ipv4_address"]
    }
  }

  ### Application Load Balancer specific attributes ###
  drop_invalid_header_fields                  = lookup(local.load_balancer, "drop_invalid_header_fields", null)
  enable_http2                                = lookup(local.load_balancer, "enable_http2", null)
  enable_tls_version_and_cipher_suite_headers = lookup(local.load_balancer, "enable_tls_version_and_cipher_suite_headers", null)
  enable_xff_client_port                      = lookup(local.load_balancer, "enable_xff_client_port", null)
  idle_timeout                                = lookup(local.load_balancer, "idle_timeout", null)
  preserve_host_header                        = lookup(local.load_balancer, "preserve_host_header", null)
  xff_header_processing_mode                  = lookup(local.load_balancer, "xff_header_processing_mode", null)

  dynamic "connection_logs" {
    for_each = lookup(local.load_balancer, "connection_logs", null) == null ? [] : [local.load_balancer["connection_logs"]]
    iterator = i
    content {
      bucket  = i.value["bucket"]
      enabled = i.value["enabled"]
      prefix  = i.value["prefix"]
    }
  }

  ### Network Load Balancer specific attributes ###
  dns_record_client_routing_policy                             = lookup(local.load_balancer, "dns_record_client_routing_policy", null)
  enforce_security_group_inbound_rules_on_private_link_traffic = lookup(local.load_balancer, "enforce_security_group_inbound_rules_on_private_link_traffic", null)

  ### Network and Gateway Load Balancer shared attributes ###
  enable_cross_zone_load_balancing = lookup(local.load_balancer, "enable_cross_zone_load_balancing", null)
}
