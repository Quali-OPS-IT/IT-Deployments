provider "vsphere" {
  vsphere_server       = var.vcenter_server
  user                 = var.vcenter_user
  password             = var.vcenter_password
  allow_unverified_ssl = var.allow_unverified_ssl
}

locals {
  use_static = trimspace(var.ipv4) != ""

  dns_list = (
    local.use_static && trimspace(var.dns_servers) != ""
    ? [for s in split(",", var.dns_servers) : trimspace(s) if trimspace(s) != ""]
    : []
  )
}

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_datastore" "ds" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "net" {
  name          = var.network_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Cluster is only required if resource_pool not provided
data "vsphere_compute_cluster" "cluster" {
  count         = trimspace(var.resource_pool) == "" ? 1 : 0
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_resource_pool" "rp" {
  count         = trimspace(var.resource_pool) != "" ? 1 : 0
  name          = var.resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

locals {
  resource_pool_id = (
    trimspace(var.resource_pool) != ""
    ? data.vsphere_resource_pool.rp[0].id
    : data.vsphere_compute_cluster.cluster[0].resource_pool_id
  )
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  folder           = trim(var.folder) != "" ? var.folder : null
  resource_pool_id = local.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds.id

  num_cpus = var.cpu
  memory   = var.memory_mb

  guest_id  = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  wait_for_guest_net_timeout = var.wait_for_guest_net_timeout

  network_interface {
    network_id   = data.vsphere_network.net.id
    adapter_type = try(data.vsphere_virtual_machine.template.network_interface_types[0], null)
  }

  # Resize the first disk (disk0) while preserving template provisioning flags
  disk {
    label            = "disk0"
    unit_number      = 0
    size             = var.disk_gb
    thin_provisioned = try(data.vsphere_virtual_machine.template.disks[0].thin_provisioned, true)
    eagerly_scrub    = try(data.vsphere_virtual_machine.template.disks[0].eagerly_scrub, false)
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    # Only apply guest customization if ipv4 provided (static)
    dynamic "customize" {
      for_each = local.use_static ? [1] : []
      content {
        linux_options {
          host_name = local.effective_hostname
          domain    = var.domain
        }

        network_interface {
          ipv4_address = var.ipv4
          ipv4_netmask = var.netmask
        }

        ipv4_gateway    = var.gateway
        dns_server_list = local.dns_list
      }
    }
  }
}
