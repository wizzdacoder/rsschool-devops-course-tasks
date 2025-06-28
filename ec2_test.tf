resource "aws_instance" "test_instance" {
  ami           = "ami-0c101f26f147fa7fd" # Amazon Linux 2 - us-east-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_a.id
  key_name      = "task2keypair"

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bastion.id] # Usás el SG que ya permite SSH

  tags = {
    Name = "EC2-Test-From-PC"
  }
}
