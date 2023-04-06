# Below block is used to set the cloud provider which provisions the resources
provider "aws" {
  region     = var.region
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

# In order to keep the terraform state file remotely below block is used
terraform {
  backend "s3" {
    bucket = "my-remote-backend-bucket-06042023"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
