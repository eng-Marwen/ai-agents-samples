# AI Agents Samples

## Azure Managed Redis

This Terraform configuration deploys a private Azure Managed Redis instance for AI chat history.

### Configuration

- Public network access is disabled.
- A private endpoint provides private network access.
- Microsoft Entra authentication is used; access keys are disabled.
- Redis connections use TLS encryption.
- Eviction is disabled to retain chat history.
- Redis persistence is configured to back up every hour.
- The default `Balanced_B3` SKU provides 3 GB memory and 2 vCPUs.

For production, configure Azure Monitor alerts and logs according to availability and retention requirements.

### Deploy

Azure CLI authentication is required:

```shell
az login
cd terraform
terraform init
terraform plan
terraform apply
```
