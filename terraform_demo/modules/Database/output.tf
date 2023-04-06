output "database_endpoint" {
  description = "The endpoint of the database"
  value       = aws_db_instance.my_rds_database.address
}

output "database_port" {
  description = "The port of the database"
  value       = aws_db_instance.my_rds_database.port
}