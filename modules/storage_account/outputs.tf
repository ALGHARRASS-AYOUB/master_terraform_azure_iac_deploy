output "my_storage_account_uri" {
  value = azurerm_storage_account.my_storage_account.primary_blob_endpoint
}