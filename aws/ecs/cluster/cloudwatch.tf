module "cloudwatch_log_group" {
  source            = "../../../atoms/CloudWatch/aws_cloudwatch_log_group"
  name              = "/ecs/${local.name}"
  retention_in_days = 30
  tags              = module.tags.all
}
