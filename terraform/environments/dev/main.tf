#main file for Dev environment
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
  region = "us-east-1"

}
#Test
terraform {
  backend "remote" {
    organization = "CloudResumeDZ"

    workspaces {
      name = "CloudResumeDev"
    }
  }
}

module "s3_bucket" {
  source     = "../../modules/s3"
  bucketName = "dev-danzresume.com"
  #this is my dev environment specific bucket name

}

module "dynamodb" {
  source     = "../../modules/dynamodb"
  table_name = "dev-site-counter"

}