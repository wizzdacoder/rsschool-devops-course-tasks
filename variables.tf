variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "my_ip" {
  description = "IP pública para habilitar el acceso SSH al bastion"
  type        = string
}

variable "key_pair_name" {
  description = "Nombre del key pair para acceder a EC2"
  type        = string
}