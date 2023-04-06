# EC2 instances resources

resource "aws_security_group" "my_ec2_sg" {
  name        = "my_web_sg"
  description = "Security group for tutorial web servers"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow all traffic through HTTP"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH from my computer"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "my_ec2_sg"
  }
}  

resource "aws_key_pair" "my_kp" {
  key_name = "my_kp"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "my_kp_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "my_kp"
}

resource "aws_instance" "my_ec2" {
  count                   = length(var.private_subnets_cidr)
  ami                     = "ami-00c39f71452c08778"
  instance_type           = "t2.micro"
  subnet_id               = element(var.private_subnets_id, count.index)
  key_name                = aws_key_pair.my_kp.key_name
  vpc_security_group_ids  = [var.security_groups_ids, aws_security_group.my_ec2_sg.id, var.alb_security_groups_ids]
  root_block_device {
            volume_type = "gp2"
            volume_size = 10
            encrypted   = true
        }

    ebs_block_device {
            device_name = "/dev/sdf"
            volume_type = "gp2"
            volume_size = 5
            encrypted   = true
        }
       

  lifecycle {
    create_before_destroy = true
  }
  user_data = filebase64("${path.module}/init_webserver.sh")
  tags = {
    Name = "my_ec2_${element(var.availability_zones, count.index)}_instance"
  }
}

resource "aws_eip" "my_ec2_eip" {

  count    = length(aws_instance.my_ec2)  
  instance = aws_instance.my_ec2[count.index].id
  vpc      = true
  tags = {
    Name = "my_eip_${count.index}"
  }
}

resource "aws_instance" "ec2_jump_server" {
  count                   = 1
  ami                     = "ami-00c39f71452c08778"
  instance_type           = "t2.micro"
  subnet_id               = element(var.public_subnets_id, count.index)
  key_name                = aws_key_pair.my_kp.key_name
  vpc_security_group_ids  = [var.security_groups_ids, aws_security_group.my_ec2_sg.id, var.alb_security_groups_ids]     

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "my_ec2_jump_server"
  }
}