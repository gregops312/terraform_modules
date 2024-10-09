module "task_role" {
  count = var.iam == null ? 0 : 1

  source             = "../../iam/group_role_user"
  name               = "ecs-${local.cluster_name}-${var.name}-task"
  path               = "/ecs/${local.cluster_name}/"
  policies           = var.iam.policies
  policy_attachments = var.iam.policy_attachments
  type               = "role"
  tags               = module.tags.all

  role = {
    assume_role_policy = module.policies.ecs_tasks_assume
    description        = "Assume for ECS task role of running services tasks"
  }
}

module "execution_role" {
  source = "../../iam/group_role_user"

  name = "ecs-${local.cluster_name}-${var.name}-execution"
  path = "/ecs/"
  type = "role"
  tags = module.tags.all

  role = {
    assume_role_policy = module.policies.ecs_tasks_assume
    description        = "Assume for ECS task execution, aka AWS task launch"
  }

  policy_attachments = [
    data.aws_iam_policy.AmazonECSTaskExecutionRolePolicy.arn,
  ]

  policies = length(local.secret_arns) >= 1 ? [{
    description = "ECS execution SecretsManager Read access"
    name        = "ecs-${local.cluster_name}-${var.name}-secretsmanager-read"
    policy      = data.aws_iam_policy_document.secrets_manager.json
  }] : []
}

data "aws_iam_policy_document" "secrets_manager" {
  statement {
    sid       = "SecretsManagerRead"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = local.secret_arns
  }
}
