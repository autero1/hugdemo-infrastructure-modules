variable "name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "server_side_encryption_kms_key_arn" {
  description = "The ARN of the CMK that should be used for the AWS KMS encryption. This attribute should only be specified if the key is different from the default DynamoDB CMK, alias/aws/dynamodb."
  type        = string
}

variable "number_of_sample_items" {
  description = "Number of sample items to generate"
  type        = number
  default     = 5
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
