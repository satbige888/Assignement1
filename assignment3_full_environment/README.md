# Combined Environment

This is a standalone Terraform root that combines all reusable modules into one parameterized deployment.

## Objective

Deploy a Linux VM with networking, NSG access, and patch management in one run.

## What It Deploys

- Resource group
- Virtual network and subnet
- Network security group with ports 22 and 80
- Ubuntu Linux VM with NGINX installed by cloud-init
- Azure Automation Account
- Log Analytics workspace
- Update Management configuration linked to the VM

## Variables You Can Control

- Region
- VM size
- Tags
- Schedule times

Those values are set in [assignment3_full_environment/terraform.tfvars](assignment3_full_environment/terraform.tfvars).

## Architecture

```text
Internet
   |
Public IP
   |
Linux VM with NGINX
   |
NIC + NSG
   |
Subnet
   |
Virtual Network

Automation Account ---- Log Analytics Workspace
         |                      |
         +---- Update Management+
                        |
                        v
                    Linux VM
```

## Usage

1. Open [assignment3_full_environment/terraform.tfvars](assignment3_full_environment/terraform.tfvars) and adjust values if needed.
2. In this folder, run `terraform init`.
3. Run `terraform plan`.
4. Run `terraform apply`.
5. After deployment, browse to `http://<public_ip>`.

## Why This Root Exists

- It combines all previous modules into one environment.
- It stays separate from the simpler Assignment 1 root.
- You can execute it only when you need the full environment.

## Outputs

- VM public IP
- VM ID
- Automation Account name
- Log Analytics workspace name
- Update configuration IDs

## Monitoring Patch Compliance

1. Open the Automation Account in Azure Portal.
2. Review the software update configuration created for the VM.
3. Open the linked Log Analytics workspace.
4. Check update status, machine compliance, and run history.

## Note

This root uses classic Azure Automation Update Management because it matches the assignment requirement. The Terraform resource is deprecated by the AzureRM provider, and Azure Update Manager is the current production replacement.