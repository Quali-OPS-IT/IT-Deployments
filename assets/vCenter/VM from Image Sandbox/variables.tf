variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "datacenter" {
  description = "vCenter datacenter name"
  type        = string
}

variable "datastore" {
  description = "Datastore name for VM storage"
  type        = string
}

variable "cluster" {
  description = "vCenter cluster name"
  type        = string
  default     = ""
}

variable "host" {
  description = "ESXi host name (optional - picks first available if not specified)"
  type        = string
  default     = ""
}

variable "resource_pool" {
  description = "Resource pool name (optional)"
  type        = string
  default     = ""
}

variable "network" {
  description = "Network name to attach the VM to"
  type        = string
}

variable "folder" {
  description = "VM folder path (optional)"
  type        = string
  default     = ""
}

variable "ova_url" {
  description = "URL to download OVA from (default: Ubuntu 22.04 minimal)"
  type        = string
  default     = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.ova"
}

variable "size" {
  description = "VM size profile (Micro, Small, Medium, Large, XLarge)"
  type        = string
  default     = "Micro"
}

variable "disk_size_gb" {
  description = "Disk size in GB (optional - overrides size profile if specified, defaults to 20GB if not set)"
  type        = number
  default     = 20
}

variable "memory_mb" {
  description = "Memory in MB (overrides size if specified)"
  type        = number
  default     = null
}

variable "cpu_count" {
  description = "Number of CPUs (overrides size if specified)"
  type        = number
  default     = null
}
