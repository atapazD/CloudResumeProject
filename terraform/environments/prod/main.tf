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
  source = "git::https://github.com/atapazD/CloudResumeProject.git//terraform/modules/s3?ref=prod"
  bucket_name = var.bucket_name
  #prod environment bucket name
  tags = {
    Environment = var.environment
    Project = "DanzResume"
  }
}

module "lambda" {
  source = "git::https://github.com/atapazD/CloudResumeProject.git//terraform/modules/lambda?ref=prod"
  table_name = var.table_name
  dynamodb_table_arn = module.dynamodb.dynamodb_table_arn
  environment = var.environment
}

module "dynamodb" {
  source = "git::https://github.com/atapazD/CloudResumeProject.git//terraform/modules/dynamodb?ref=prod"
  table_name = var.table_name
}

module "route53" {
  source = "git::https://github.com/atapazD/CloudResumeProject.git//terraform/modules/route53?ref=prod"
}

module "acm" {
  source = "git::https://github.com/atapazD/CloudResumeProject.git//terraform/modules/acm?ref=prod"
}

module "api_gateway" {
  source = "git::https://github.com/atapazD/CloudResumeProject.git//terraform/modules/api_gateway?ref=prod"
}

module "cloudfront" {
  source = "git::https://github.com/atapazD/CloudResumeProject.git//terraform/modules/cloudfront?ref=prod"
}

