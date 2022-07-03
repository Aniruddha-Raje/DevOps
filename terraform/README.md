terraform init

terraform plan -var-file dev.tfvars

terraform apply -var-file dev.tfvars

terraform update -var-file dev.tfvars


terraform init - This will initialise Terraform and install any dependencies your file requires. 
    This downloads the necessary packages for the GitHub provider
terraform plan - Create a plan for what infrastructure will be changed
terraform apply - Create the infrastructure

terraform destroy - allows us to destroy all resources created within the folder.
terraform destroy -target aws_instance.my_ec2

Terraform State Files
Terraform stores the state of the infrastructure that are created in the .tf files in the Terraform State File.
This state file allows Terraform to map real world resources to your configuration files.