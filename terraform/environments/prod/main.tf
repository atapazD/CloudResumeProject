#main file for production environment
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
  
}
#Test
terraform {
  backend "remote" {
    organization = "CloudResumeDZ"

    workspaces {
      name = "CloudResumeProd"
    }
  }
}

module "s3_bucket" {
  source = "../../../modules/s3"
  bucket_name = "danzresume.com"
  #prod environment bucket name
  tags = {
    Environment = "production"
    Project = "DanzResume"
  }
}