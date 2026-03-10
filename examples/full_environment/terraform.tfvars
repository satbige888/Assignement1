region                          = "East US"
resource_group_name             = "assignment1-combined-rg"
vnet_name                       = "assignment1-combined-vnet"
subnet_name                     = "combined-subnet"
nsg_name                        = "assignment1-combined-nsg"
vm_name                         = "assignment1-combined-vm"
vm_size                         = "Standard_B2s"
admin_username                  = "azureuser"
admin_password                  = "P@ssword1234!"
automation_account_name         = "assignment1combinedauto"
log_analytics_name              = "assignment1-combined-law"
log_analytics_retention_in_days = 30
update_configuration_name       = "assignment1-combined-weekly-patching"
schedule_start_date             = "2026-03-15"
schedule_timezone               = "UTC"
schedule_duration               = "PT2H"

tags = {
  environment = "assignment"
  workload    = "combined-environment"
  owner       = "student"
}

schedule_times = [
  {
    day  = "Sunday"
    time = "02:00"
  }
]