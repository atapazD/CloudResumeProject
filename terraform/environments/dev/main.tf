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

module "s3" {
  source = "git::https://github.com/atapazD/CloudResumeProject.git//terraform/modules/s3?ref=dev"
  bucketName = "dev-danzresume.com"
}


# module "dynamodb" {
#   source     = "../../modules/dynamodb"
#   table_name = var.table_name

# }

# module "lambda" {
#   source             = "../../modules/lambda"
#   table_name         = var.table_name
#   dynamodb_table_arn = module.dynamodb.dynamodb_table_arn
#   environment        = var.environment
# }
# #updated dev environment!