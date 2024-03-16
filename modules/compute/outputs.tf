output "vms" {
  value = [for vm in azurerm_linux_virtual_machine.linuxvm : [vm.public_ip_address , vm.admin_username]]
}