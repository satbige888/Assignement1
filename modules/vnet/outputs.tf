output "vnet_id" {
  description = "Virtual network ID."
  value       = azurerm_virtual_network.this.id
}

output "subnet_id" {
  description = "Subnet ID used by the web server."
  value       = azurerm_subnet.this.id
}