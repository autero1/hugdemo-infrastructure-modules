module "dynamodb" {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-dynamodb-table.git?ref=v1.1.0"

  name      = var.name
  hash_key  = "id"
  range_key = "name"

  server_side_encryption_enabled     = true
  server_side_encryption_kms_key_arn = var.server_side_encryption_kms_key_arn

  attributes = [
    {
      name = "id"
      type = "S"
    },
    {
      name = "name"
      type = "S"
    },
  ]

  tags = var.common_tags
}

resource "random_pet" "random" {
  count  = var.number_of_sample_items
  length = 2
}

resource "aws_dynamodb_table_item" "random" {
  count      = var.number_of_sample_items
  table_name = module.dynamodb.dynamodb_table_id
  hash_key   = "id"
  range_key  = "name"
  item       = jsonencode({ "id" : { "S" : random_uuid.random[count.index].id }, "name" : { "S" : random_pet.random[count.index].id } })
}

resource "random_uuid" "random" {
  count = var.number_of_sample_items
}
