variable "location" {}
variable "rg_name" {}
variable "network_security_group_id" {
  
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
