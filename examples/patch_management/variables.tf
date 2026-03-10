variable "region" {
  description = "Azure region for patch-management resources."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Resource group containing the VM and patch-management resources."
  type        = string
}

variable "automation_account_name" {
  description = "Azure Automation Account name."
  type        = string
}

variable "log_analytics_name" {
  description = "Log Analytics workspace name."
  type        = string
}

variable "log_analytics_retention_in_days" {
  description = "Retention period in days for Log Analytics data."
  type        = number
  default     = 30
}

variable "update_configuration_name" {
  description = "Base name for weekly patch deployment configurations."
  type        = string
}

variable "vm_id" {
  description = "ID of the existing VM to enroll in patch management."
  type        = string
}

variable "schedule_start_date" {
  description = "Date used to construct the initial update schedule start time in YYYY-MM-DD format."
  type        = string
}

variable "schedule_timezone" {
  description = "Time zone used by the update schedule."
  type        = string
  default     = "UTC"
}

variable "schedule_duration" {
  description = "Patch window duration in ISO 8601 format."
  type        = string
  default     = "PT2H"
}

variable "schedule_times" {
  description = "Weekly patch windows expressed as day and 24-hour time."
  type = list(object({
    day  = string
    time = string
  }))
}

variable "tags" {
  description = "Tags applied to patch-management resources."
  type        = map(string)
  default = {
    environment = "assignment"
    workload    = "patch-management"
  }
}