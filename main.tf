terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  # backend initialization for the terraform.tfstate note: variables do not work in this scope 
  backend "azurerm" {
    resource_group_name  = "terraform-ressource-group"
    storage_account_name = "terraformbackendstate000"
    container_name       = "terraformbackendstate000-container"
    key                  = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

  # subscription_id    = var.SUBSCRIPTION_ID
  # tenant_id       = var.TENANT_ID
  # client_id       = var.CLIENT_ID
  # client_secret   = var.CLIENT_SECRET
}


# ceation of resource group

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}


# creation of virtual network

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet.name
  location            = var.location
  address_space       = var.vnet["address_space"]
  resource_group_name = azurerm_resource_group.rg.name
}

# creation of subnets

resource "azurerm_subnet" "subnet_web" {
  name                 = var.subnet_web.name
  resource_group_name  = var.rg_name
  address_prefixes     = var.subnet_web["address_prefixes"]
  virtual_network_name = azurerm_virtual_network.vnet.name
}


# creation of public ips

resource "azurerm_public_ip" "public_ip" {
  resource_group_name = azurerm_resource_group.rg.name
  name                = var.public_ip_address["name"]
  location            = azurerm_resource_group.rg.location
  allocation_method   = var.public_ip_address["allocation_method"]

}


# creation of network security group

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg["name"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location


  dynamic "security_rule" {
    for_each = var.nsg_ports
    content {

      name                       = security_rule.key
      priority                   = tostring(var.nsg_ports_priority["${security_rule.key}"])
      access                     = "Allow"
      direction                  = "Inbound"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = tostring(security_rule.value)
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}


# creation of network interface (nic)

resource "azurerm_network_interface" "nic" {
  name                = var.nic["name"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  ip_configuration {
    name                          = var.nic.name_config
    public_ip_address_id          = azurerm_public_ip.public_ip.id
    private_ip_address_allocation = var.nic["private_ip_address_allocation"]
    subnet_id                     = azurerm_subnet.subnet_web.id
  }

}

# association network security group with nic 

resource "azurerm_network_interface_security_group_association" "nic_association_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# generate a random bytes for the account storage name
resource "random_id" "name_account_storage" {
  keepers = {
    # generate a new id only when a new rg is created
    resource_group = azurerm_resource_group.rg.name
  }
  byte_length = 8
}

# creation of local storage to store logs of dedicated vms
resource "azurerm_storage_account" "name" {
  name                     = random_id.name_account_storage.hex
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = var.storage_account["account_tier"]
  account_replication_type = var.storage_account["account_replication_type"]
}

# creation of vms

resource "azurerm_linux_virtual_machine" "linuxvm" {
  for_each                        = toset(var.vms["usernames"])
  name                            = each.key
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  admin_username                  = each.key
  disable_password_authentication = true
  size                            = var.vms["size"]
  network_interface_ids           = [azurerm_network_interface.nic.id]

  os_disk {
    name                 = var.vms["os_disk"]["name"]
    caching              = var.vms["os_disk"]["caching"]
    storage_account_type = var.vms["os_disk"]["storage_account_type"]
  }

  admin_ssh_key {
    username   = each.key
    public_key = file(var.public_ssh_key)
  }

  source_image_reference {
    publisher = var.vms["image"]["publisher"]
    offer     = var.vms["image"]["offer"]
    sku       = var.vms["image"]["sku"]
    version   = var.vms["image"]["version"]
  }
}