#variables specific to production
variable "table_name" {
  type = string
  default = "siteCounter"
}

variable "environment" {
  type = string
  default = "prod"
}

variable "bucket_name" {
  type = string
  default = "danzresume.com"
}

variable "siteName" {
  type = string
  default = "danzresume.com"
}