output "public_ip" {
  description = "Public IP address of the Linux web server."
  value       = module.vm.public_ip
}

output "vm_id" {
  description = "ID of the Linux virtual machine."
  value       = module.vm.vm_id
}