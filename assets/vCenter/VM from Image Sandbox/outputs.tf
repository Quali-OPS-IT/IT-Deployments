output "vm_id" {
  value       = vsphere_virtual_machine.vm.id
  description = "VM ID"
}

output "vm_uuid" {
  value       = vsphere_virtual_machine.vm.uuid
  description = "VM UUID"
}

output "vm_name" {
  value       = vsphere_virtual_machine.vm.name
  description = "VM name"
}

output "vm_guest_ip" {
  value       = vsphere_virtual_machine.vm.guest_ip_addresses
  description = "VM guest IP addresses"
}
