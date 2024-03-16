
# ssh key generation

module "tls__ssh_keys" {
  source = "../../modules/ssh_key_generation"
}

# ceation of resource group
module "rg" {
  source   = "../../modules/resourse_group"
  rg_name  = var.rg_name
  location = var.location
}


# creation of virtual network

module "network" {
  source                    = "../../modules/network"
  rg_name                   = module.rg.rg_name
  location                  = module.rg.rg_location
  network_security_group_id = module.security.nsg_id

}

# creation of network security group

module "security" {
  source   = "../../modules/security"
  location = module.rg.rg_location
  rg_name  = module.rg.rg_name
}




# creation of storage account

module "storage_account" {
  source   = "../../modules/storage_account"
  rg_name  = module.rg.rg_name
  location = module.rg.rg_location
}

# creation of vm

module "compute" {
  source                 = "../../modules/compute"
  rg_name                = module.rg.rg_name
  location               = module.rg.rg_location
  my_storage_account_uri = module.storage_account.my_storage_account_uri
  network_interface_ids  = [module.network.network_interface_ids]
  public_ssh_key         = module.tls__ssh_keys.public_ssh_key
  private_ssh_key        = module.tls__ssh_keys.private_ssh_key
}