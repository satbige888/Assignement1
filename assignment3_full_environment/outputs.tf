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