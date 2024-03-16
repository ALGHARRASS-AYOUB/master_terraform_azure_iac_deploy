variable "location" {
  description = "azure  region"
  type        = string
  default     = "East US"
}

variable "rg_name" {
  description = "the rg name "
  type        = string
  default     = "terraform-rg"
}

variable "SUBSCRIPTION_ID" {
  description = "SUBSCRIPTION_ID"
  type        = string
  default     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

variable "CLIENT_SECRET" {
  description = "CLIENT_SECRET"
  type        = string
  default     = "xxxxxxxxxxxxxxx"
}

variable "CLIENT_ID" {
  description = "CLIENT_ID"
  type        = string
  default     = "xxxxxxxxxxxxxxx"
}

variable "TENANT_ID" {
  description = "TENANT_ID"
  type        = string
  default     = "xxxxxxxxxxxxxxx"
}
