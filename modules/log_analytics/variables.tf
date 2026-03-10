variable "name" {
  description = "Log Analytics workspace name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the Log Analytics workspace."
  type        = string
}

variable "region" {
  description = "Azure region for the Log Analytics workspace."
  type        = string
}

variable "retention_in_days" {
  description = "Retention period for workspace data."
  type        = number
}

variable "tags" {
  description = "Tags applied to the Log Analytics workspace."
  type        = map(string)
}