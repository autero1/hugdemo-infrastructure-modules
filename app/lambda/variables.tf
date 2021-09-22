variable "name" {
  description = "Name of the lambda function"
  type        = string
}

variable "vpc_subnet_ids" {
  description = "List of subnet IDs to run the Lambda in"
  type        = list(string)
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "ID of the VPC to deploy the Lambda in"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN of the KMS key to encrypt data with"
  type        = string
}

variable "alb_listener_arn" {
  description = "ARN of the ALB listener to create target group in"
  type        = string
}
