# TODO: Define real rules
module "sg_default" {
  source = "../../../atoms/VPC/aws_security_group"

  name = local.service_name
  tags = merge(module.tags.all, {
    Name = local.service_name
  })

  # TODO: remove this, by fixing tagging/naming
  vpc_id = data.aws_vpc.self.id

  egress_rules = [{
    cidr_blocks = ["0.0.0.0/0"]
    description = "All-in"
    from_port   = 0
    protocol    = "all"
    to_port     = 0
    self        = true
  }]

  ingress_rules = [{
    cidr_blocks = ["0.0.0.0/0"]
    description = "All-out"
    from_port   = 0
    protocol    = "all"
    to_port     = 0
    self        = true
  }]
}
