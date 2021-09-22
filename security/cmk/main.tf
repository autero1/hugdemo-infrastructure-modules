locals {
  key_name = var.create_random_suffix ? "${var.name}-${random_pet.random.id}" : var.name
}

module "cmk" {
  source                  = "git::https://github.com/cloudposse/terraform-aws-kms-key.git?ref=0.10.0"
  name                    = local.key_name
  description             = "KMS CMK ${local.key_name}"
  deletion_window_in_days = 7
  enable_key_rotation     = false
  alias                   = "alias/${local.key_name}"
  tags                    = var.common_tags
}

resource "random_pet" "random" {
  length = 2
}
