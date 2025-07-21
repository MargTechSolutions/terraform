variable "domain_name" {
  description = "The domain name to request an SSL certificate for."
  default= "dev.ladymarg.com" #change based on environment
  type        = string
}

variable "hosted_zone_id" {
  description = "The Route53 Hosted Zone ID for the domain."
  type        = string
}

variable "elb_name" {
  description = "The Classic ELB name to attach the certificate to. Optional."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}