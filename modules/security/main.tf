# creation of network security group

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg["name"]
  resource_group_name = var.rg_name
  location            = var.location


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
