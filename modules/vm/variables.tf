variable "name" {
  description = "Linux VM name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the VM."
  type        = string
}

variable "region" {
  description = "Azure region for the VM."
  type        = string
}

variable "vm_size" {
  description = "Azure VM size."
  type        = string
}

variable "admin_username" {
  description = "Administrator username."
  type        = string
}

variable "admin_password" {
  description = "Administrator password."
  type        = string
  sensitive   = true
}

variable "subnet_id" {
  description = "Subnet ID where the VM NIC is deployed."
  type        = string
}

variable "nsg_id" {
  description = "Network security group ID attached to the VM NIC."
  type        = string
}

variable "tags" {
  description = "Tags applied to VM resources."
  type        = map(string)
}