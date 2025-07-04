output "bastion_public_ip" {
  description = "IP pública del Bastion Host"
  value       = aws_instance.bastion.public_ip
}

output "bastion_private_ip" {
  description = "IP privada del Bastion Host"
  value       = aws_instance.bastion.private_ip
}

output "test_instance_public_ip" {
  description = "IP pública de la instancia EC2 de prueba (subnet pública)"
  value       = aws_instance.test_instance.public_ip
}

output "test_instance_private_ip" {
  description = "IP privada de la instancia EC2 de prueba"
  value       = aws_instance.test_instance.private_ip
}

output "nat_instance_public_ip" {
  description = "IP pública de la instancia NAT"
  value       = aws_instance.nat.public_ip
}

output "nat_instance_private_ip" {
  description = "IP privada de la instancia NAT"
  value       = aws_instance.nat.private_ip
}
