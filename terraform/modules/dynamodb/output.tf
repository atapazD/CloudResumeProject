output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table, this needs to get passed to my lambda module"
  value       = aws_dynamodb_table.siteCountTable.arn
}
