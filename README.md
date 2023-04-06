# terraform-demo
Terraform code to create VPC , Subnets, ALB , RDS , Jump server


Note: we need to pass access keys, secret access key, db username, db password and environment values in terraform.tfvars file and execute terraform commands from inside of the terraform-demo folder
 
Prerequisite: A bucket already created in your account to place our state file , also pass the name of the bucket in provider.tf file present in root directory.
