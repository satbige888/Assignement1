variable "name" {
  description = "Base name for update management resources."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing Automation and Log Analytics resources."
  type        = string
}

variable "automation_account_id" {
  description = "Automation Account ID."
  type        = string
}

variable "workspace_id" {
  description = "Log Analytics workspace ID."
  type        = string
}

variable "vm_id" {
  description = "Virtual machine ID linked to patch deployment."
  type        = string
}

variable "schedule_start_date" {
  description = "Date used to construct the initial schedule start time in YYYY-MM-DD format."
  type        = string
}

variable "schedule_timezone" {
  description = "Time zone for the weekly update schedule."
  type        = string
}

variable "schedule_duration" {
  description = "Patch window duration in ISO 8601 format."
  type        = string
}

variable "schedule_times" {
  description = "Weekly patch windows expressed as day and 24-hour time."
  type = list(object({
    day  = string
    time = string
  }))
}