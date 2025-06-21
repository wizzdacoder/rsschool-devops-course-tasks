# Bastion Host EC2 instance en subnet pública A
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_a.vpc_id
  associate_public_ip_address = true
  key_name                    = var.ssh_key_name

  vpc_security_group_ids      = [aws_security_group.bastion.id]

  tags = {
    Name = "bastion-host"
  }
}



