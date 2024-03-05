#This output value is referencing the output of the S3 module which 
#gives the website_endpoint for the Dev-Environment

output "dev_site" {
  description = "Development site URL"
  value       = module.s3.website_endpoint
}
