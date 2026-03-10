# Terraform Assignments

This repository is organized into separate runnable sections for each assignment.

## Structure

- [assignment1_virtual_machines_networking](assignment1_virtual_machines_networking): secure Linux VM with networking and NSG
- [assignment2_patch_management](assignment2_patch_management): Azure Automation, Log Analytics, and weekly patch scheduling for an existing VM
- [assignment3_full_environment](assignment3_full_environment): full combined environment using all modules in one deployment
- [modules](modules): reusable Terraform modules shared by all assignment roots

## Shared Modules

- `modules/vnet`
- `modules/nsg`
- `modules/vm`
- `modules/automation_account`
- `modules/log_analytics`
- `modules/update_management`

## Workflows

- `.github/workflows/assignment1.yml`: validates `assignment1_virtual_machines_networking`
- `.github/workflows/assignment2.yml`: validates `assignment2_patch_management`
- `.github/workflows/assignment3.yml`: validates `assignment3_full_environment`

## Notes

- Assignment 2 and Assignment 3 use classic Azure Automation Update Management because that matches the exercise requirements.
- That Terraform resource is deprecated by the AzureRM provider, and Azure Update Manager is the production replacement.