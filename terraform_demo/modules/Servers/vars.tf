variable "vpc_id" {
  description = "VPC ID of the resource that we created"
  type        = string    
}

variable "availability_zones" {
  type        = list(any)
  description = "AZ in which all the resources will be deployed"
}

variable "environment" {
  description = "Deployment Environment"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
}

variable "public_subnets_id" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
}

variable "private_subnets_id" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
}

variable "security_groups_ids" {
  description = ""
}

variable "alb_security_groups_ids" {
  description = ""
}



