variable "location" {}
variable "rg_name" {}
variable "my_storage_account_uri" {}
variable "network_interface_ids" {}
variable "public_ssh_key" {}
variable "private_ssh_key" {}

variable "keys_folder" {
  description = "where the private key will be stored"
  default = "../../environments/prod/keys/"
}

variable "public_key_location" {
  description = "the public key location"
  type        = string
  default     = "../../environments/prod/keys/azure_ssh_key.pub"
}


variable "key_pair_name" {
  description = "the name of the public key "
  type        = string
  default     = "azure_ssh_key"
}



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

variable "vms" {
  description = "$ the vms on the resource group configuration variables"
  type = object({
    usernames = list(string)
    os_disk = object({
      name                 = string
      caching              = string
      storage_account_type = string
    })
    image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    size = string
  })
  # do not forget. if you want multiple vms in your resource group, you need to specify to those vms a nic each.
  default = {
    usernames = ["node-1"]
    os_disk = {
      name                 = "custom_os_disk"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }
    # size = "Standard_DS1_v2"
    size = "Standard_D2s_v3"
  }
}

variable "vm_controle_node" {
  description = "the controle node on the resource"
  type        = string
  default     = "controle-node"
}


