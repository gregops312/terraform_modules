output "arn" {
  description = "ARN that identifies the cluster"
  value       = module.cluster.arn
}

output "id" {
  description = "ARN that identifies the cluster"
  value       = module.cluster.id
}

output "name" {
  value = module.cluster.name
}

output "cloudwatch_log_group" {
  value = module.cloudwatch_log_group.name
}

output "sg_default_id" {
  value = module.sg_default.id
}
