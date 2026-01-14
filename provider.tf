terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }
  # terraform tfstate file remote backend section 
  backend "s3" {
    bucket = "asiwko-terraform-state-bucket"
    key = "dev/asiwko/terraform.tfstate"
    encrypt = true
    region = "us-east-1"
    #dynamodb_table = "asiwko-tf-locks"
    
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1" # additional changes
}