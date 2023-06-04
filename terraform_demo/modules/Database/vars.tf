variable "settings" {
  description = "Configuration settings"
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

variable "vpc_id" {
  description = "VPC ID of the resource that we created"
  type        = string    
}

variable "ec2_security_groups_ids" {
  description = "Security Group ID of the EC2 instances"
}

variable "private_db_subnets_id" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
}
