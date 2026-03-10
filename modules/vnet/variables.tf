variable "name" {
  description = "Virtual network name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the virtual network."
  type        = string
}

variable "region" {
  description = "Azure region for the virtual network."
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network."
  type        = list(string)
}

variable "subnet_name" {
  description = "Subnet name."
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Subnet address prefixes."
  type        = list(string)
}

variable "tags" {
  description = "Tags applied to the virtual network."
  type        = map(string)
}