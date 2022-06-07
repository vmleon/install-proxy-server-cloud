# Install Proxy Server in the Cloud

Deploy with Terraform and Ansible a Proxy Server for ethical hacking.

## Requirements

- Oracle Cloud Infrastructure account
- OCI CLI, Terraform and Ansible configured.

## Set Up

Clone this repository in your local machine:
```
git clone https://github.com/vmleon/install-proxy-server-cloud.git
```

Change directory to the `install-proxy-server-cloud`:
```
cd install-proxy-server-cloud
```

Export an environment variable with the base directory:
```
export BASE_DIR=$(pwd)
```

## Deploy

Change directory to `terraform`:
```
cd $BASE_DIR/terraform
```

Authenticate with OCI, it will open a browser where you can log in:
```
oci session authenticate
```

Copy the template for the terraform variables:
```
cp terraform.tfvars.template terraform.tfvars
```

Edit the variables values:
```
vim terraform.tfvars
```

You have to modify:
- `config_file_profile` from the `oci session` command
- `tenancy_ocid` from your OCI tenancy
- `compartment_ocid` the compartment you want, or root compartment (that is the `tenancy_ocid`)
- `ssh_public_key` with your public SSH key, usually in `~/.ssh/id_rsa.pub`

Initialize the terraform provider:
```
terraform init
```

Apply the infrastructure, with auto approval:
```
terraform apply -auto-approve
```

Provision with Ansible:
- NGINX and static content for the frontend
- Node, pm2, code and dependencies for the backend

```
ansible-playbook -i generated/proxy.ini ../ansible/proxy.yaml
```

Print the load balancer IP from the terraform output again:
```
terraform output proxy_public_ips
```

## Clean Up

Destroy all the infrastructure:
```
terraform destroy -auto-approve
```