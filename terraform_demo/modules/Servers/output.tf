output "my_public_ip" {
  description = "The public IP address of the web server"
  value       = aws_eip.my_ec2_eip[0].public_ip
  depends_on = [aws_eip.my_ec2_eip]
}

output "ec2_public_dns" {
  description = "The public DNS address of the web server"
  value       = aws_eip.my_ec2_eip[0].public_dns
  depends_on = [aws_eip.my_ec2_eip]
}

output "ec2_instances_ids" {
  description = "IDs of the ec2 instances in private subnet"
  value = ["${aws_instance.my_ec2.*.id}"]
}

output "ec2_security_groups_ids" {
  description = "Security group IDs of the ec2 instances"
  value = aws_security_group.my_ec2_sg.id
}