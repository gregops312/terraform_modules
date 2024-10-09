output "target_group_arn" {
  value = one(module.target_group[*].arn)
}
