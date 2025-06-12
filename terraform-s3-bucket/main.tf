terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "task1-s3-bucket" {
  bucket = "my-task1-s3-bucket-777"
  acl    = "private"

  tags = {
    Name = "MyTaskBucket"
  }
}
