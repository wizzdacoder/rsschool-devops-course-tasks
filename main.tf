provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "alan-k8s-terraform-state"
    key    = "networking/terraform.tfstate"
    region = "us-east-1"
  }
}