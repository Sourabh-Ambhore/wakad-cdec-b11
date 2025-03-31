resource "aws_s3_bucket" "bucket_for_code" {
  bucket = "wakad-b11-tf-code-27-03"
  tags = {
    Name        = "TF bucket"
    
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
}


