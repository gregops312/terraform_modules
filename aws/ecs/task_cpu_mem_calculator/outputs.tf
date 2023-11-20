output "cpu" {
  description = "The calculated number of CPU units based on the values defined in the container definitions."
  value       = local.cpu
}

output "memory" {
  description = "The calculated memory based on the values defined in the container definitions."
  value       = local.memory
}
