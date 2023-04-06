output "vpc_id" {
  description = "ID of the VPC"
  value = aws_vpc.vpc.id
}

output "public_subnets_id" {
  description = "Public Subnet IDs"
  value = ["${aws_subnet.public_subnet.*.id}"]
}

output "private_subnets_id" {
  description = "Private Subnet IDs"
  value = ["${aws_subnet.private_subnet.*.id}"]
}

output "private_db_subnets_id" {
  description = "Database Private Subnet IDs"
  value = ["${aws_subnet.private_db_subnet.*.id}"]
}

output "default_sg_id" {
  description = "ID of the default Security Group"
  value = aws_security_group.default.id
}

output "public_route_table" {
  description = "ID of the public route table"
  value = aws_route_table.public.id
}