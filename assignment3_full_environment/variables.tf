variable "region" {
  description = "Azure region for all resources."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group created by this root module."
  type        = string
  default     = "assignment1-combined-rg"
}

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default = {
    environment = "assignment"
    workload    = "combined-environment"
  }
}

variable "vnet_name" {
  description = "Virtual network name."
  type        = string
  default     = "assignment1-combined-vnet"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network."
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "subnet_name" {
  description = "Subnet name for the VM."
  type        = string
  default     = "combined-subnet"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet."
  type        = list(string)
  default     = ["10.20.1.0/24"]
}

variable "nsg_name" {
  description = "Network security group name."
  type        = string
  default     = "assignment1-combined-nsg"
}

variable "vm_name" {
  description = "Linux virtual machine name."
  type        = string
  default     = "assignment1-combined-vm"
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
}

variable "automation_account_name" {
  description = "Azure Automation Account name."
  type        = string
  default     = "assignment1combinedauto"
}

variable "log_analytics_name" {
  description = "Log Analytics workspace name."
  type        = string
  default     = "assignment1-combined-law"
}

variable "log_analytics_retention_in_days" {
  description = "Retention period for Log Analytics data."
  type        = number
  default     = 30
}

variable "update_configuration_name" {
  description = "Base name for weekly patch deployment configurations."
  type        = string
  default     = "assignment1-combined-weekly-patching"
}

variable "schedule_start_date" {
  description = "Date used to construct the initial update schedule start time in YYYY-MM-DD format."
  type        = string
  default     = "2026-03-15"
}

variable "schedule_timezone" {
  description = "Time zone used by the update schedule."
  type        = string
  default     = "UTC"
}

variable "schedule_duration" {
  description = "Patch window duration in ISO 8601 format."
  type        = string
  default     = "PT2H"
}

variable "schedule_times" {
  description = "Weekly patch windows expressed as day and 24-hour time."
  type = list(object({
    day  = string
    time = string
  }))
  default = [
    {
      day  = "Sunday"
      time = "02:00"
    }
  ]
}