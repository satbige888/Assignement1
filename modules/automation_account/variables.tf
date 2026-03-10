variable "name" {
  description = "Automation Account name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the Automation Account."
  type        = string
}

variable "region" {
  description = "Azure region for the Automation Account."
  type        = string
}

variable "tags" {
  description = "Tags applied to the Automation Account."
  type        = map(string)
}