resource "azurerm_linux_virtual_machine" "linuxvm" {
  for_each                        = toset(var.vms["usernames"])
  name                            = each.key
  resource_group_name             = var.rg_name
  location                        = var.location
  admin_username                  = each.key
  disable_password_authentication = true
  size                            = var.vms["size"]
  network_interface_ids           = [var.network_interface_ids[0]] # it is a tuple of one element, so we get the first by indexing

  os_disk {
    name                 = var.vms["os_disk"]["name"]
    caching              = var.vms["os_disk"]["caching"]
    storage_account_type = var.vms["os_disk"]["storage_account_type"]
  }

  admin_ssh_key {
    username   = each.key
    public_key = "${var.public_ssh_key}"
    # public_key = file(var.public_key_location)
  }

  boot_diagnostics {
    storage_account_uri = var.my_storage_account_uri
  }

  source_image_reference {
    publisher = var.vms["image"]["publisher"]
    offer     = var.vms["image"]["offer"]
    sku       = var.vms["image"]["sku"]
    version   = var.vms["image"]["version"]
  }
}

resource "local_file" "private_key_output" {
  content =  "${var.private_ssh_key}"
  filename          =  "${var.keys_folder}${var.key_pair_name}.pem"
  file_permission = 0400
}