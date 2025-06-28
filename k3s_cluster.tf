# Master node
resource "aws_instance" "k3s_master" {
  ami                         = "ami-0c101f26f147fa7fd" # Amazon Linux 2 us-east-1
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private_a.id
  key_name                    = var.key_pair_name
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.k3s_nodes.id]

  tags = {
    Name = "k3s-master"
  }
}

# Worker node
resource "aws_instance" "k3s_worker" {
  ami                         = "ami-0c101f26f147fa7fd"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private_b.id
  key_name                    = var.key_pair_name
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.k3s_nodes.id]

  tags = {
    Name = "k3s-worker"
  }
}
