terraform {
  required_version = ">= 1.0"
  
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.6"
    }
  }
}

provider "vsphere" {
  # Uses environment variables:
  # VSPHERE_USER, VSPHERE_PASSWORD, VSPHERE_SERVER, VSPHERE_ALLOW_UNVERIFIED_SSL
}

# VM size profiles
locals {
  size_map = {
    "Micro"  = { cpu = 1,  memory = 2048 }
    "Small"  = { cpu = 2,  memory = 4096 }
    "Medium" = { cpu = 4,  memory = 8192 }
    "Large"  = { cpu = 8,  memory = 16384 }
    "XLarge" = { cpu = 16, memory = 32768 }
  }
  
  selected_size = lookup(local.size_map, var.size, local.size_map["Micro"])
  
  cpu_count    = var.cpu_count != null ? var.cpu_count : local.selected_size.cpu
  memory_mb    = var.memory_mb != null ? var.memory_mb : local.selected_size.memory
}

# Data sources to get vCenter objects
data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  count         = var.cluster != "" ? 1 : 0
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.resource_pool != "" ? var.resource_pool : (var.cluster != "" ? "${var.cluster}/Resources" : "Resources")
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
  name          = var.host != "" ? var.host : null
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Deploy VM from OVA URL (Ubuntu Cloud Image)
resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  host_system_id   = data.vsphere_host.host.id
  folder           = var.folder != "" ? var.folder : null

  num_cpus = local.cpu_count
  memory   = local.memory_mb
  guest_id = "ubuntu64Guest"

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  # Deploy from OVA - using Ubuntu 22.04 minimal cloud image
  ovf_deploy {
    remote_ovf_url = var.ova_url
    disk_provisioning = "thin"
    ovf_network_map = {
      "VM Network" = data.vsphere_network.network.id
    }
  }

  disk {
    label = "disk0"
    size  = var.disk_size_gb
  }

  lifecycle {
    ignore_changes = [
      ovf_deploy,
    ]
  }
}
