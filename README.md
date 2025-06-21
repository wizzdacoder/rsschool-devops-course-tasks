# TASK 2 - RS School Devops course - Kubernetes Networking Infrastructure with Terraform

## Overview

This project contains Terraform code to provision the basic networking infrastructure required for a Kubernetes (K8s) cluster on AWS.
It includes:

- A Virtual Private Cloud (VPC)
- Two public subnets in different Availability Zones (AZs)
- Two private subnets in different AZs
- Internet Gateway
- Routing configuration to allow communication between subnets and internet access where appropriate
- NAT instance setup for private subnet internet access
- Bastion host for secure SSH access to private instances
- Security Groups for network security
- Remote backend configuration using an S3 bucket to store Terraform state

## Project Structure
├── backend.tf # S3 backend configuration and bucket resource
├── main.tf # Main Terraform configuration and provider setup
├── variables.tf # Input variables definitions
├── terraform.tfvars # Variables values (not committed to repo)
├── outputs.tf # Output values from Terraform
├── networking/ # Directory for networking-related resources
│ ├── vpc.tf
│ ├── subnets.tf
│ ├── internet_gateway.tf
│ ├── nat_instance.tf
│ ├── routes.tf
│ ├── security.tf
│ └── bastion.tf
└── .github/workflows/ # GitHub Actions workflows for Terraform CI
└── terraform.yml

## Usage

### Prerequisites

- AWS CLI configured with proper credentials  
- Terraform installed (version 1.7.5 or compatible)  
- SSH keypair created and registered in AWS for EC2 access  

### Steps to Deploy

1. Clone the repository  
2. Modify `terraform.tfvars` with your environment-specific values (AWS region, VPC CIDR, SSH key name, etc.)  
3. Initialize Terraform:

terraform init

4. Review the execution plan:

terraform plan

3. Apply the infrastructure:

terraform apply

Confirm by typing "yes".

### NOTES
Terraform state is stored remotely in an S3 bucket for collaboration and state consistency
The backend bucket is created automatically if not existing
Versioning and public access blocking are enabled on the S3 bucket for safety
Use the bastion host to securely SSH into private subnet instances using SSH ProxyJump (ssh -J)

### Additional Features
GitHub Actions workflow automates validation and planning on every push or pull request
Security groups limit network access as per best practices
NAT instance allows private subnet instances to access the internet securely

### Author
Alan Demian Beltramo @wizzdacoder

