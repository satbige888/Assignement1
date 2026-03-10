variable "name" {
  description = "Network security group name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the network security group."
  type        = string
}

variable "region" {
  description = "Azure region for the network security group."
  type        = string
}

variable "rules" {
  description = "Security rules applied to the NSG."
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "tags" {
  description = "Tags applied to the network security group."
  type        = map(string)
}