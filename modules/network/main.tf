# creation of virtual network

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet.name
  location            = var.location
  address_space       = var.vnet["address_space"]
  resource_group_name = var.rg_name
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
  resource_group_name = var.rg_name
  name                = var.public_ip_address["name"]
  location            = var.location
  allocation_method   = var.public_ip_address["allocation_method"]

}


# creation of network interface (nic)

resource "azurerm_network_interface" "nic" {
  name                = var.nic["name"]
  resource_group_name = var.rg_name
  location            = var.location
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
  network_security_group_id = var.network_security_group_id
}
