# vsphere-generic-vm

Clones a VM from a vSphere template and optionally applies static IP guest customization.

## Inputs
- vcenter_server, vcenter_user, vcenter_password, allow_unverified_ssl
- datacenter, cluster (or resource_pool), datastore, network_name, template_name
- vm_name, cpu, memory_mb, disk_gb
- ipv4, netmask, gateway, dns_servers (optional; if ipv4 empty -> no customization)

## Notes
- IP outputs require VMware Tools in the guest.
- Static IP customization requires the guest OS to support vSphere customization (common for many Linux templates).
