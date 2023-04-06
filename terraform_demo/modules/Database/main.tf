# Resources for RDS instance

resource "aws_security_group" "my_db_sg" {
  name        = "my_db_sg"
  description = "Security group for databases"
  vpc_id      = var.vpc_id
  ingress {
    description     = "Allow MySQL traffic from only the web sg"
    from_port       = "3306"
    to_port         = "3306"
    protocol        = "tcp"
    security_groups = [var.ec2_security_groups_ids]
  }
  tags = {
    Name = "my_db_sg"
  }
}

resource "aws_db_subnet_group" "my_subnet_group" {
  name        = "my_db_subnet_group"
  description = "DB subnet group"
  subnet_ids  = [for subnet in var.private_db_subnets_id : subnet]
}

resource "aws_db_instance" "my_rds_database" {
  identifier             = "my-rds-database"
  allocated_storage      = var.settings.database.allocated_storage
  engine                 = var.settings.database.engine
  engine_version         = var.settings.database.engine_version
  instance_class         = var.settings.database.instance_class
  db_name                = var.settings.database.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.my_subnet_group.id
  vpc_security_group_ids = [aws_security_group.my_db_sg.id]
  skip_final_snapshot    = var.settings.database.skip_final_snapshot
}
