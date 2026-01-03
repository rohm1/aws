# AWS Configs

Terraform/Tofu files for my AWS configs.

Init with: `tofu init -backend-config=path/to/your/backend-settings.tfvars`

Backend settings file:
```
bucket       = "bucket-name"
key          = "terraform.tfstate"
use_lockfile = true
```
