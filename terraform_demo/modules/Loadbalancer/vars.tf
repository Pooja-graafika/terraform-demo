variable "vpc_id" {
  description = "VPC ID of the resource that we created"
  type        = string    
}

variable "environment" {
  description = "Deployment Environment"
}

variable "ec2_instances_ids" {
  type        = list(any)
  description = "List of EC2 instances IDs"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
}

variable "private_subnets_id" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
}

variable "public_subnets_id" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
}