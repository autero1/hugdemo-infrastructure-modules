variable "name" {
  description = "Name of the CMK"
  type = string
}

variable "create_random_suffix" {
  description = "Create random suffix for the CMK"
  type = bool
  default = false
}

variable "common_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
