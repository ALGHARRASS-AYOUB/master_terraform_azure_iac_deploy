
# backend initialization for the terraform.tfstate note: variables do not work in this scope 
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-ressource-group"
    storage_account_name = "terraformbackendstate000"
    container_name       = "terraformbackendstate000-container"
    key                  = "prod.terraform.tfstate"
    subscription_id      = "xxxxxxxxxxxxxxx"
    tenant_id            = "xxxxxxxxxxxxxxx"
    client_id            = "xxxxxxxxxxxxxxx"
    client_secret        = "xxxxxxxxxxxxxxx"
  }
}
