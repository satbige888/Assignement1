# Assignment 1: Virtual Machines and Networking

This repository contains two separate Terraform solutions:

- A main root that deploys a secure Linux web server for Assignment 1
- Separate reusable patch-management modules plus a standalone example root
- A standalone combined environment that deploys the web server and patch management together

## Deliverables

- Reusable modules for `vnet`, `nsg`, and `vm`
- Root Terraform code in `main.tf`, `variables.tf`, `outputs.tf`, and `terraform.tfvars`
- NSG rules for ports 22 and 80
- Linux VM bootstrapped with NGINX through cloud-init
- Public IP output for the deployed VM
- Reusable modules for `automation_account`, `log_analytics`, and `update_management`
- Standalone patch-management usage example in `examples/patch_management`

## Main Assignment 1 Deployment

The main root deploys:

- One resource group
- One virtual network and subnet
- One network security group
- One Ubuntu Linux virtual machine
- One public IP address

Why this structure:

- `vnet` separates reusable networking
- `nsg` keeps inbound access rules explicit
- `vm` handles compute, networking attachment, and NGINX installation

Usage:

1. Review [terraform.tfvars](terraform.tfvars).
2. Run `terraform init`.
3. Run `terraform plan`.
4. Run `terraform apply`.
5. Open `http://<public_ip>` after deployment.

Expected result:

- SSH on port 22
- HTTP on port 80
- NGINX reachable on the VM public IP

## Patch Management Modules

Patch management is intentionally separate from the web-server root so the existing Assignment 1 deployment stays unchanged.

Modules included:

- `modules/automation_account`: creates the Azure Automation Account
- `modules/log_analytics`: creates the Log Analytics workspace
- `modules/update_management`: links the VM to update management and creates a weekly patch schedule

Example usage:

- Use [examples/patch_management/main.tf](examples/patch_management/main.tf) with an existing `vm_id`
- Copy `terraform.tfvars.example` in that folder to `terraform.tfvars`
- Run `terraform init`, `terraform plan`, and `terraform apply` inside that example folder

## Module Summary

- `modules/vnet`: virtual network and subnet
- `modules/nsg`: network security group and inbound rules
- `modules/vm`: public IP, NIC, NSG association, and Linux VM
- `modules/automation_account`: Azure Automation Account
- `modules/log_analytics`: Log Analytics workspace
- `modules/update_management`: linked service and weekly patch deployment

## Monitoring Patch Compliance

After deploying the separate patch-management example:

1. Open the Automation Account in Azure Portal.
2. Review the software update configuration linked to the VM.
3. Open the linked Log Analytics workspace.
4. Check machine status, missing updates, and job history.
5. Confirm the weekly schedule runs successfully.

## Note

The example uses classic Azure Automation Update Management because that matches the assignment requirement. The Terraform resource is deprecated by the AzureRM provider, and Azure Update Manager is the current production replacement.

## Combined Environment

If you want to deploy networking, the VM, and patch management together in one run, use [examples/full_environment/main.tf](examples/full_environment/main.tf). That folder is a separate root with its own [examples/full_environment/terraform.tfvars](examples/full_environment/terraform.tfvars) and [examples/full_environment/README.md](examples/full_environment/README.md).