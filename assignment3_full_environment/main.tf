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