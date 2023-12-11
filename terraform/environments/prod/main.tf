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
  bucket_name = var.bucket_name
  #prod environment bucket name
  tags = {
    Environment = var.environment
    Project = "DanzResume"
  }
}

module "lambda" {
  source = "../../modules/lambda"
  table_name = var.table_name
  dynamodb_table_arn = module.dynamodb.dynamodb_table_arn
  environment = var.environment
}

module "dynamodb" {
  source = "../../modules/dynamodb"
  table_name = var.table_name
}

module "route53" {
  source = "../../modules/route53"
}

module "acm" {
  source = "../../modules/acm"
}

module "api_gateway" {
  source = "../../modules/api_gateway"
}

module "cloudfront" {
  source = "../../modules/cloudfront"
}

