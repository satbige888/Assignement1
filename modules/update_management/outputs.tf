output "linked_service_id" {
  description = "Log Analytics linked service ID."
  value       = azurerm_log_analytics_linked_service.this.id
}

output "software_update_configuration_ids" {
  description = "Software update configuration IDs by weekday."
  value = {
    for key, config in azurerm_automation_software_update_configuration.this : key => config.id
  }
}