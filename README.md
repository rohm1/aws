# AWS Configs

Terraform/Tofu files for my AWS configs.

## Starting with this repository

- Clone the repository

- Run `tofu init`

- Create a `terraform.tfvars` file:
```ini
allowed_ips   = [list of IPs that are allowed to access the buckets]
account_email = "your email"
```

- Remove the `backend` block in [providers.tf](providers.tf)

- Make your changes, and run `tofu apply` when ready

- Re-add the `backend` block to [providers.tf](providers.tf)

- Upload the generated `terraform.tfstate` to your new `state` bucket

- Re-init the project: `tofu init -backend-config=path/to/your/backend-settings.tfvars`

Backend settings file:
```ini
bucket       = "state-xxx"
key          = "terraform.tfstate"
use_lockfile = true
```

- Install the AWS CLI as described here: [https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

- Login: `aws login`

- Export shell variables:
```sh
export AWS_REGION=$(aws configure get region)
export $(aws configure export-credentials --format env-no-export | xargs)
```

- Verify: `tofu plan` should not display any changes

- Delete the local `terraform.tfstate` file

## Working with buckets

There is a [bucket](modules/bucket) module that can create a bucket with some opinionated security defaults. All the buckets are created the same. This list of buckets can be found in [buckets.tf](buckets.tf). It also create an IAM user that has full permissions on the bucket. You need to specify some allowed IPs for the users. To create an access key for the `state` bucket, run the following: `aws iam create-access-key --user-name "bucket-user-$(aws s3api list-buckets --query "Buckets[].Name" --output text --prefix state)"`