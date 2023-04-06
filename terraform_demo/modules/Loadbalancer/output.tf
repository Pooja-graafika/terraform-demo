output "alb_security_groups_ids" {
  description = "The load balancer security group ID"
  value = aws_security_group.my-alb-sg.id
}
