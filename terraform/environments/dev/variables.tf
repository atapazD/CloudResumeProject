#variables specific to Dev
variable "bucketName" {
  type    = string
  default = "dev.danzresume.com"
}

variable "table_name" {
  type    = string
  default = "dev-site-counter"
}