locals {
  bucket_name = var.create_random_suffix ? "${var.name}-${random_pet.random.id}" : var.name
}

resource "random_pet" "random" {
  length = 2
}

module "site" {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-s3-bucket.git?ref=v2.9.0"

  bucket        = local.bucket_name
  acl           = "public-read"
  force_destroy = true

  attach_policy = false

  tags = var.common_tags

  versioning = {
    enabled = false
  }

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket       = module.site.s3_bucket_id
  key          = "index.html"
  acl          = "public-read"
  content_type = "text/html"
  content = templatefile("${path.module}/index.html", {
    url : var.api_url,
    environment : var.environment
  })
}

resource "aws_s3_bucket_object" "error" {
  bucket       = module.site.s3_bucket_id
  key          = "error.html"
  acl          = "public-read"
  content_type = "text/html"
  source       = "${path.module}/error.html"
}

