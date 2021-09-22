output "s3_bucket_website_endpoint" {
  description = "Website endpoint for the S3 bucket"
  value       = module.site.s3_bucket_website_endpoint
}

output "s3_bucket_website_domain" {
  description = "Website domain for the S3 bucket"
  value       = module.site.s3_bucket_website_domain
}

output "s3_bucket_id" {
  description = "ID of the S3 bucket"
  value       = module.site.s3_bucket_id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = module.site.s3_bucket_arn
}
