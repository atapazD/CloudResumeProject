variable "table_name" {
  description = "Name of the dynamodb table to be used by lambda function for specific environment"
  type = string
}

variable "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table being passed by the DynamoDB module"
  type = string
}

variable "environment" {
  description = "The environment that the lambda code is being used in to determine which database to use"
  type = string
}