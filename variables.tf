variable "location" {
  description = "azure  region"
  type        = string
  default     = "East US"
}

variable "rg_name" {
  description = "the rg name "
  type        = string
  default     = "terraform-rg"
}

# configurations of terraform state file

variable "resource_group_name_state" {
  description = "rg name holding the terraform state file"
  type        = string
  default     = "terraform-ressource-group"
}

variable "storage_account_name_state" {
  description = "the account storage holding the terraform.tfstate"
  type        = string
  default     = "terraformbackendstate000"
}

variable "container_name_state" {
  description = "the container within the account storage holding the terraform.tfstate"
  type        = string
  default     = "terraformbackendstate000-container"
}


variable "key_state" {
  description = "the key name of terraform.tfstate"
  type        = string
  default     = "prod.terraform.tfstate"
}



variable "vnet" {
  description = "configuration of the vvirtual network "
  type = object({
    name          = string
    address_space = list(string)
  })
  default = {
    name          = "vnet"
    address_space = ["10.0.0.0/16"]
  }
}


variable "azs" {
  description = "avialable zones in the region to use"
  type        = map(string)
  default = {
    "first_east" = ""
  }
}

variable "subnet_web" {
  description = "subnet configuration of the vnet "
  type = object({
    name             = string
    address_prefixes = list(string)
  })
  default = {
    name             = "subnet_web"
    address_prefixes = ["10.0.2.0/24"]
  }
}

variable "public_ip_address" {
  description = "configuration of public ip address"
  type = object({
    name              = string
    allocation_method = string
  })
  default = {
    name              = "public_ip_address"
    allocation_method = "Dynamic"
  }
}

variable "nic" {
  description = "the network interface nic configuration"
  type = object({
    name                          = string
    name_config                   = string
    private_ip_address_allocation = string
  })

  default = {
    name                          = "nic"
    name_config                   = "nic_config"
    private_ip_address_allocation = "Dynamic"
  }
}


variable "nsg" {
  description = "sg for the second vnet"
  type = object({
    name = string
  })
  default = {
    name = "nsg"
  }

}

variable "nsg_ports" {
  description = "ports of nsg rules"
  type        = map(string)
  default = {
    "http"        = "80",
    "ssh"         = "22",
    "tomcat_http" = "8080",
    "mysql"       = "3306"
  }
}

variable "nsg_ports_priority" {
  description = "ports of nsg rules"
  type        = map(string)
  default = {
    "http"        = "1001",
    "ssh"         = "1000",
    "tomcat_http" = "1002",
    "mysql"       = "1003"
  }
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
}

variable "vm_controle_node" {
  description = "the controle node on the resource"
  type        = string
  default     = "controle-node"
}

variable "public_ssh_key" {
  description = "ssh public key to copy on the vms"
  type        = string
  default     = "azure_ssh_key.pub"
}

variable "private_ssh_key" {
  description = "ssh private key "
  type        = string
  default     = "azure_ssh_key"
}


variable "key_pair_name" {
  description = "the name of the public key "
  type        = string
  default     = "azure_ssh_key"

}