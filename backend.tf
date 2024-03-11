# data "terraform_remote_state" "terraform_state" {
#   backend = "azurerm"
#   config = {
#     storage_account_name = "terraformbackendstate000"
#     container_name       = "terraformbackendstate000-container"
#     key                  = "prod.terraform.tfstate"
#   }
# }