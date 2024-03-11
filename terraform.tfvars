location = "East US"

resource_group_name_state = "terraform-ressource-group"


storage_account_name_state = "terraformbackendstate000"


container_name_state = "terraformbackendstate000-container"



key_state = "prod.terraform.tfstate"


rg_name = "terraform-rg"
vnet = {
  name          = "vnet"
  address_space = ["10.0.0.0/16"]
}



subnet_web = {
  name             = "subnet_web"
  address_prefixes = ["10.0.2.0/24"]
}

public_ip_address = {
  name              = "public_ip_address"
  allocation_method = "Dynamic"
}

nic = {
  name                          = "nic"
  name_config                   = "nic_config"
  private_ip_address_allocation = "Dynamic"
}

nsg = {
  name = "nsg"
}

nsg_ports = {
  "http"        = "80",
  "ssh"         = "22",
  "tomcat_http" = "8080",
  "mysql"       = "3306"
}

nsg_ports_priority = {
  "http"        = "1001",
  "ssh"         = "1000",
  "tomcat_http" = "1002",
  "mysql"       = "1003"
}

storage_account = {
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# do not forget. if you want multiple vms in your resource group, you need to specify to those vms a nic each.
vms = {
  usernames = ["node-1"]
  size      = ""
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
vm_controle_node = "controle-node"

public_ssh_key = "azure_ssh_key.pub"

private_ssh_key = "azure_ssh_key"

key_pair_name = "azure_ssh_key"
