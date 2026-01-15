terraform {
  required_providers {
    # We will be working with AWS and so will need the AWS provider
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }
  # We want to store the Terraform state file in aws using an S3 bucket.
  backend "s3" {
    bucket = "asiwko-terraform-state-bucket"
    key = "dev/asiwko/terraform.tfstate"
    encrypt = true
    region = "us-east-1"
    #dynamodb_table = "asiwko-tf-locks"
  }
}

provider "aws" {
  # Let's specify the region here.
  region = "us-east-1" 
}