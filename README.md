# terraform_devopsjourney
repository of devops studies 

> For security reasons, the folder containing the kubeconfig settings (.kube/config) and the `terraform.tfvars` file has been removed from the versioning.

## Before anything else
Make a copy of the file `terraform.tfvars.example` naming the copy `terraform.tfvars`. Then change the values of the variables to the values corresponding to your scenario.

```bash
cp terraform.tfvars.example terraform.tfvars
```

## Adjusting the variable file
A brief example of what the file should look like. 
```plain
do_token     = "dop_v1_89767f7d98f7f798ds7f9ds7f9ds7f9ds7f89d7212649jk4g34ghhg4"
ssh_key_name = "default"
region       = "nyc1"
```

## Applying the changes and creating the infrastructure
After you have properly configured the project `variables`, just start terraform, format the file and then apply it, and your infrastructure will be properly created.

run
```bash
terraform fmt && terraform init && terraform apply 
```

> At the end of the studies, it is recommended that you destroy all the infrastructure you have created, so as not to generate unnecessary costs.

run 
```bash
terraform destroy
```