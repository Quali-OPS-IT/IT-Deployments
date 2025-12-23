output "vm_id" {
  description = "Terraform resource ID"
  value       = vsphere_virtual_machine.vm.id
}

output "vm_moid" {
  description = "Managed Object ID (moid)"
  value       = vsphere_virtual_machine.vm.moid
}

output "vm_name" {
  description = "VM name"
  value       = vsphere_virtual_machine.vm.name
}

output "ip_address" {
  description = "Default IP reported by VMware Tools (may be empty if tools not running or DHCP not ready)"
  value       = vsphere_virtual_machine.vm.default_ip_address
}

output "guest_ip_addresses" {
  description = "All guest IPs reported by VMware Tools (may be empty)"
  value       = vsphere_virtual_machine.vm.guest_ip_addresses
}
