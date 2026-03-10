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

module "automation_account" {
  source              = "../../modules/automation_account"
  name                = var.automation_account_name
  resource_group_name = var.resource_group_name
  region              = var.region
  tags                = var.tags
}

module "log_analytics" {
  source              = "../../modules/log_analytics"
  name                = var.log_analytics_name
  resource_group_name = var.resource_group_name
  region              = var.region
  retention_in_days   = var.log_analytics_retention_in_days
  tags                = var.tags
}

module "update_management" {
  source                = "../../modules/update_management"
  name                  = var.update_configuration_name
  resource_group_name   = var.resource_group_name
  automation_account_id = module.automation_account.automation_account_id
  workspace_id          = module.log_analytics.workspace_id
  vm_id                 = var.vm_id
  schedule_start_date   = var.schedule_start_date
  schedule_timezone     = var.schedule_timezone
  schedule_duration     = var.schedule_duration
  schedule_times        = var.schedule_times
}
