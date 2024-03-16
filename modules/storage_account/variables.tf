variable "storage_account" {
  description = "the storage account "
  type = object({
    account_tier             = string
    account_replication_type = string
  })
  default = {
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

variable location {}
variable rg_name {}

# variable rg_id {
#   default = ""
#   description = "Resource group ID"
# }
