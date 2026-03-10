# Assignment 1: Virtual Machines and Networking

This is the dedicated Terraform root for Assignment 1.

## Objective

Deploy a secure Linux web server in Azure using reusable Terraform modules.

## What It Deploys

- Resource group
- Virtual network and subnet
- Network security group with ports 22 and 80
- Ubuntu Linux virtual machine
- Public IP address
- NGINX installed with cloud-init

## Files

- `main.tf`: provider setup, root resources, and module usage
- `variables.tf`: configurable inputs
- `outputs.tf`: public IP and VM ID outputs
- `terraform.tfvars`: example configuration values

## Usage

1. Review [assignment1_virtual_machines_networking/terraform.tfvars](assignment1_virtual_machines_networking/terraform.tfvars).
2. Run `terraform init` in this folder.
3. Run `terraform plan`.
4. Run `terraform apply`.
5. Open `http://<public_ip>` after deployment.

## Module Usage

- `../modules/vnet`
- `../modules/nsg`
- `../modules/vm`

## Outputs

- VM public IP
- VM ID