variable "siteAlias" {
  type        = list(any)
  description = "Aliases used for Cloudfront Distribution"
  default     = ["danzresume.com", "www.danzresume.com"]
}