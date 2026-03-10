variable "region" {
  description = "Azure region for all resources."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group created by the root module."
  type        = string
  default     = "assignment1-rg"
}

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default = {
    environment = "assignment"
    workload    = "linux-webserver"
  }
}

variable "vnet_name" {
  description = "Virtual network name."
  type        = string
  default     = "assignment1-vnet"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network."
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "subnet_name" {
  description = "Subnet name for the web server."
  type        = string
  default     = "web-subnet"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the web subnet."
  type        = list(string)
  default     = ["10.10.1.0/24"]
}

variable "nsg_name" {
  description = "Network security group name."
  type        = string
  default     = "assignment1-web-nsg"
}

variable "vm_name" {
  description = "Linux virtual machine name."
  type        = string
  default     = "assignment1-web-vm"
}

variable "vm_size" {
  description = "Azure VM size."
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Administrator username for the Linux VM."
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Administrator password for the Linux VM."
  type        = string
  sensitive   = true
  default     = "P@ssword1234!"
}