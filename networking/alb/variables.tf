variable "name" {
  description = "Name of the ALB"
  type        = string
}

variable "vpc_subnet_ids" {
  description = "List of subnet ids for the ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC to deploy the ALB to"
  type        = string
}

variable "allow_connections_from_cidr_blocks" {
  description = "List of CIDR formatted IP ranges to allow access from"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
