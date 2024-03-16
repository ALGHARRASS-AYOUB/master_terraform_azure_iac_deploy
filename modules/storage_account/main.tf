
# generate a random bytes for the account storage name
resource "random_id" "name_account_storage" {
  keepers = {
    # generate a new id only when a new rg is created
    resource_group = var.rg_name
  }
  byte_length = 8
}

# creation of local storage to store logs of dedicated vms
resource "azurerm_storage_account" "my_storage_account" {
  name                     = random_id.name_account_storage.hex
  location                 = var.location
  resource_group_name      = var.rg_name
  account_tier             = var.storage_account["account_tier"]
  account_replication_type = var.storage_account["account_replication_type"]
}

resource "azurerm_storage_container" "my_storage_container" {
  name                  = "diag-my-storage-container"
  storage_account_name  = azurerm_storage_account.my_storage_account.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "my_storage_blob" {
  name = "sample.vhd"

  storage_account_name   = azurerm_storage_account.my_storage_account.name
  storage_container_name = azurerm_storage_container.my_storage_container.name

  type = "Page"
  size = 5120
}