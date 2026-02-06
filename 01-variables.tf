variable "LINODE_API_KEY" {
  description = "The key to the Linode API"
  type        = string
  sensitive   = true
}

variable "instance_region" {
  description = "The region to create the instance"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Which instance type to create"
  type    = string
  default = "m7i-flex.large"
}

variable "domain_name" {
  description = "The domain to create instance records in."
  type    = string
  default = "siwko.org"
}

variable "domain_soa_email" {
  description = "The domain manager e-mail address."
  type    = string
  default = "asiwko@siwko.org"
}