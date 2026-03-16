terraform {
  required_providers {
    # We will be working with AWS and so will need the AWS provider
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
    # in order to update DNS on linode, we'll need the linode provider.
    linode = {
      source  = "linode/linode"
    }
  }

   backend "local" {
    path = "/container_shared/tfstate/aws.tfstate"
  }

  # This project started with the state stored in the provider's oject storage.  
  # I moved it to local storage as providers charge for object storage and there was no benefit once the exercise was complete.
  # backend "s3" {
  #   bucket = "asiwko-terraform-state-bucket"
  #   key = "dev/asiwko/terraform.tfstate"
  #   encrypt = true
  #   region = "us-east-1"
  # }
}

provider "aws" {
  region = var.instance_region 
}

provider "linode" {
  token = var.LINODE_API_KEY
}