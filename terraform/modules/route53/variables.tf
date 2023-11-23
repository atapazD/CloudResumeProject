variable "siteName" {
  type        = string
  description = "Name of the site to deploy"
  default     = "danzresume.com"
}

variable "nsRecords" {
  type        = list(any)
  description = "NS records from the domain registrar"
  default     = []
}

variable "soaRecords" {
  type        = list(any)
  default     = []
  description = "SOA record/s of the website"
}
