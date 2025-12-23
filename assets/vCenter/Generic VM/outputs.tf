output "vm_id" {
  value = vsphere_virtual_machine.vm.id
}

output "vm_name" {
  value = vsphere_virtual_machine.vm.name
}

output "ip_address" {
  # Requires VMware Tools for accurate reporting
  value = vsphere_virtual_machine.vm.default_ip_address
}
