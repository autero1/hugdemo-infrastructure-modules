variable "name" {
  description = "Name of the VPC"
  type        = string
}

variable "cidr" {
  description = "CIDR range for the VPC"
  type        = string
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
