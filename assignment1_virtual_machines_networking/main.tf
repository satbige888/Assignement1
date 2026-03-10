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