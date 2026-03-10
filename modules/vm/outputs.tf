output "vm_id" {
  description = "Linux virtual machine ID."
  value       = azurerm_linux_virtual_machine.this.id
}

output "public_ip" {
  description = "Public IP address of the Linux web server."
  value       = azurerm_public_ip.this.ip_address
}

output "network_interface_id" {
  description = "Network interface ID attached to the VM."
  value       = azurerm_network_interface.this.id
}