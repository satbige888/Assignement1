resource "azurerm_log_analytics_linked_service" "this" {
  resource_group_name = var.resource_group_name
  workspace_id        = var.workspace_id
  read_access_id      = var.automation_account_id
}

resource "azurerm_automation_software_update_configuration" "this" {
  for_each = {
    for schedule in var.schedule_times : lower(schedule.day) => schedule
  }

  name                  = "${var.name}-${lower(each.value.day)}"
  automation_account_id = var.automation_account_id
  duration              = var.schedule_duration
  virtual_machine_ids   = [var.vm_id]

  linux {
    classifications_included = ["Critical", "Security"]
    reboot                   = "IfRequired"
  }

  schedule {
    frequency          = "Week"
    interval           = 1
    advanced_week_days = [each.value.day]
    start_time         = "${var.schedule_start_date}T${each.value.time}:00Z"
    time_zone          = var.schedule_timezone
    is_enabled         = true
    description        = "Weekly patching window for ${each.value.day} at ${each.value.time} ${var.schedule_timezone}"
  }

  depends_on = [azurerm_log_analytics_linked_service.this]
}