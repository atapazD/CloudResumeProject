output "website_endpoint" {
  description = "The website endpoint URL for the S3 bucket"
  value       = "http://${aws_s3_bucket.bucketSiteName.bucket_regional_domain_name}/"
}
