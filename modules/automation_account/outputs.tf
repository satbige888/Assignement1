output "automation_account_id" {
  description = "Automation Account ID."
  value       = azurerm_automation_account.this.id
}

output "automation_account_name" {
  description = "Automation Account name."
  value       = azurerm_automation_account.this.name
}