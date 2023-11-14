locals {
  ### ECS TASK SIZE CALCULATOR ###
  ### BEGIN ###
  ###
  ### The following code helps to automatically calculate the CPU and Memory size for ECS Task Definition.
  ### The values for CPU and Memory are calculated based on the values defined in the container_definitions variable for
  ### each container.
  ###
  ### Constraints are automatically applied to the calculated values based on the AWS documentation,
  ### and the values are rounded up to the nearest valid value.
  ### https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size
  ###
  ### If either the CPU or Memory are outside of allowable limits, then the logic with return a null value causing a
  ### hard failure from the resource.

  container_definitions = jsondecode(var.container_definitions)

  raw_cpu = sum([for i in local.container_definitions : i.cpu])

  # If both memory and memoryReservation are defined, then use the larger of the two values.
  raw_memory = sum([for i in local.container_definitions :
    max(
      i.memory == null ? 0 : i.memory,
      i.memoryReservation == null ? 0 : i.memoryReservation
    )
  ])

  # If the calculated CPU is less than 256, then set it to 256. Otherwise round up to the nearest power of 2.
  refined_cpu = local.raw_cpu < 256 ? 256 : pow(2, ceil(log(local.raw_cpu, 2)))

  # If memory is less than 512, then set it to 512. Otherwise round up to the nearest multiple of 1024.
  refined_memory = local.raw_memory < 512 ? 512 : ceil(local.raw_memory / 1024) * 1024

  limits = {
    256   = [512, 1024, 2048]
    512   = range(1024, (4 * 1024 + 1), 1024)
    1024  = range((2 * 1024), (8 * 1024 + 1), 1024)
    2048  = range((4 * 1024), (16 * 1024 + 1), 1024)
    4096  = range((8 * 1024), (30 * 1024 + 1), 1024)
    8192  = range((16 * 1024), (60 * 1024 + 1), (4 * 1024))
    16384 = range((32 * 1024), (120 * 1024 + 1), (8 * 1024))
  }

  # Check if the calculated CPU and Memory are within the allowable limits.
  valid_cpu = contains(keys(local.limits), local.refined_cpu)
  valid_mem = contains(local.limits[local.refined_cpu], local.refined_memory)

  # If the calculated CPU or Memory are outside of the allowable limits, then set the value to null.
  # This is done purposely to cause a hard failure from the resource.
  final_cpu = local.valid_cpu ? local.refined_cpu : null

  final_memory = (
    local.valid_mem ?
    local.refined_memory : local.refined_memory < local.limits[local.refined_cpu][0] ?
    local.limits[local.refined_cpu][0] : null
  )

  cpu    = local.final_cpu
  memory = local.final_memory
  ### END ###
  ### ECS TASK SIZE CALCULATOR ###
}
