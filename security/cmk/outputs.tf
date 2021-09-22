output "alias_arn" {
  description = "ARN of the key alias"
  value       = module.cmk.alias_arn
}

output "alias_name" {
  description = "Name of the key alias"
  value       = module.cmk.alias_name
}

output "key_arn" {
  description = "ARN of the CMK"
  value       = module.cmk.key_arn
}

output "key_id" {
  description = "ID of the CMK Key"
  value       = module.cmk.key_id
}
