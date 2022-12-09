### Commented out name_prefix and name_suffix since there can only be one config stream and you don't see the name anywhere
### When you have names and the name changes, it requires manual intervention.

# variable "name_prefix" {
#   description = "String to prefix on object names"
#   type = "string"
# }

# variable "name_suffix" {
#   description = "String to append to object names. This is optional, so start with dash if using"
#   type = "string"
#   default = ""
# }

variable "include_global_resource_rules" {
  description = "True/False to add global resource rules to Config. Default is false"
  type        = string
  default     = false
}

variable "required_tags_enabled" {
  description = "True/False to add RequiredTags to Config. Default is false"
  type        = string
  default     = false
}

variable "required_tags" {
  description = "Map of tag keys, and optionally values, that are required."
  type        = map(any)
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Maps of tags to apply to resources"
  default     = {}
}
