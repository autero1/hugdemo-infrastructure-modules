data "aws_region" "current" {}

locals {
  subnets = cidrsubnets(var.cidr, 5, 5, 5, 5, 5, 5)
  region  = data.aws_region.current.id
}

module "vpc" {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-vpc.git?ref=v3.6.0"

  name = var.name

  cidr = var.cidr

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets  = [local.subnets[0], local.subnets[1], local.subnets[2]]
  private_subnets = [local.subnets[3], local.subnets[4], local.subnets[5]]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = var.common_tags
}


