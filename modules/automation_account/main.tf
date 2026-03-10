resource "azurerm_automation_account" "this" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group_name
  sku_name            = "Basic"
  tags                = var.tags
}