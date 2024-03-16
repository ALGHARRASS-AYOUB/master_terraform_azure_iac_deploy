variable "location" {}
variable "rg_name" {}

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
    # "http"        = "80",
    "ssh"         = "22"
  }
}

variable "nsg_ports_priority" {
  description = "ports of nsg rules"
  type        = map(string)
  default = {
    # "http"        = "1001",
    "ssh"         = "1000"
  }
}
