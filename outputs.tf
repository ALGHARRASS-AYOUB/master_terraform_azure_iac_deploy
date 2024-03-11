
# output "vm_node_ip" {
#   description = "the ip of the  node = "
#   value       = azurerm_linux_virtual_machine.linuxvm.public_ip_address
# }

output "vms" {
  value = [for vm in azurerm_linux_virtual_machine.linuxvm : vm.public_ip_address]
}