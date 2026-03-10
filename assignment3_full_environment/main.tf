terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.62"
    }
  }
}

provider "azurerm" {
  features {}
}

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

locals {
  nsg_rules = [
    {
      name                       = "allow-ssh"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-http"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.region
  tags     = var.tags
}

module "vnet" {
  source                  = "../modules/vnet"
  name                    = var.vnet_name
  resource_group_name     = azurerm_resource_group.main.name
  region                  = azurerm_resource_group.main.location
  address_space           = var.vnet_address_space
  subnet_name             = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
  tags                    = var.tags
}

module "nsg" {
  source              = "../modules/nsg"
  name                = var.nsg_name
  resource_group_name = azurerm_resource_group.main.name
  region              = azurerm_resource_group.main.location
  rules               = local.nsg_rules
  tags                = var.tags
}

module "vm" {
  source              = "../modules/vm"
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.main.name
  region              = azurerm_resource_group.main.location
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  subnet_id           = module.vnet.subnet_id
  nsg_id              = module.nsg.nsg_id
  tags                = var.tags
}

module "automation_account" {
  source              = "../modules/automation_account"
  name                = var.automation_account_name
  resource_group_name = azurerm_resource_group.main.name
  region              = azurerm_resource_group.main.location
  tags                = var.tags
}

module "log_analytics" {
  source              = "../modules/log_analytics"
  name                = var.log_analytics_name
  resource_group_name = azurerm_resource_group.main.name
  region              = azurerm_resource_group.main.location
  retention_in_days   = var.log_analytics_retention_in_days
  tags                = var.tags
}

module "update_management" {
  source                = "../modules/update_management"
  name                  = var.update_configuration_name
  resource_group_name   = azurerm_resource_group.main.name
  automation_account_id = module.automation_account.automation_account_id
  workspace_id          = module.log_analytics.workspace_id
  vm_id                 = module.vm.vm_id
  schedule_start_date   = var.schedule_start_date
  schedule_timezone     = var.schedule_timezone
  schedule_duration     = var.schedule_duration
  schedule_times        = var.schedule_times
}

output "public_ip" {
  description = "Public IP address of the Linux web server."
  value       = module.vm.public_ip
}

output "vm_id" {
  description = "ID of the Linux virtual machine."
  value       = module.vm.vm_id
}

output "automation_account_name" {
  description = "Automation Account name used for patch management."
  value       = module.automation_account.automation_account_name
}

output "log_analytics_workspace_name" {
  description = "Log Analytics workspace receiving update data."
  value       = module.log_analytics.workspace_name
}

output "update_configuration_ids" {
  description = "Weekly patch deployment configuration IDs."
  value       = module.update_management.software_update_configuration_ids
}