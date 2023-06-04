variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "region" {
  default     = "us-east-1"
  description = "AWS Region where we create the resources"
}

variable "environment" {
  description = "Deployment Environment"
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
  default     = ["10.0.10.0/24", "10.0.9.0/24"]
}

variable "private_db_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for database Private Subnet"
  default     = ["10.0.7.0/24", "10.0.8.0/24"]
}

variable "settings" {
  description = "Configuration settings to pass the values for rds database"
  type        = map(any)
  default = {
    "database" = {
      allocated_storage   = 10            // storage in gigabytes
      engine              = "mysql"       // engine type
      engine_version      = "8.0.32"      // engine version
      instance_class      = "db.t2.micro" // rds instance type
      db_name             = "tutorial"    // database name
      skip_final_snapshot = true
    }
  }
}
variable "db_username" {
  description = "Database master user"
  type        = string
  sensitive   = true
}
variable "db_password" {
  description = "Database master user password"
  type        = string
  sensitive   = true
}

