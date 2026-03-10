# Patch Management Example

This is a separate root configuration that demonstrates how to use the patch-management modules without modifying the existing web-server root.

## Files

- `main.tf`: provider setup and module composition
- `variables.tf`: example inputs for the patch-management root
- `outputs.tf`: outputs returned after deployment
- `terraform.tfvars.example`: sample values you can adapt

## What It Does

- Creates an Azure Automation Account
- Creates a Log Analytics workspace
- Links the Automation Account to Log Analytics
- Enrolls an existing VM in update management
- Schedules a weekly Linux patch deployment

## Why It Is Separate

- The existing root remains dedicated to the web server and networking assignment.
- This example can be reused for any VM by changing only the `vm_id` input.

## How To Use It

1. Deploy the existing root configuration first.
2. Copy `terraform.tfvars.example` to `terraform.tfvars` in this folder.
3. Replace `vm_id` with the actual VM ID from the deployed VM.
4. Run `terraform init` in this folder.
5. Run `terraform plan`.
6. Run `terraform apply`.

## Monitoring Patch Compliance

After deployment:

1. Open the Automation Account in Azure Portal.
2. Open Update Management or the software update configuration associated with the VM.
3. Review the linked Log Analytics workspace for machine status, missing updates, and job history.
4. Confirm the weekly schedule runs on the expected day and time.

Note:
This example uses the classic Azure Automation Update Management Terraform resource because that is what the assignment asks for. Azure has deprecated that service, and Azure Update Manager is the modern replacement for real environments.