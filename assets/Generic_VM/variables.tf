variable "vcenter_server" {
  type        = string
  description = "vCenter FQDN or IP"
}

variable "vcenter_user" {
  type        = string
  description = "vCenter username"
}

variable "vcenter_password" {
  type        = string
  description = "vCenter password"
  sensitive   = true
}

variable "allow_unverified_ssl" {
  type        = string
  description = "Allow insecure SSL for vCenter (yes/no)"
  default     = "yes"
}


variable "datacenter" {
  type        = string
  description = "vSphere datacenter name"
}

variable "resource_pool" {
  type        = string
  description = "vSphere resource pool name"
}

variable "datastore" {
  type        = string
  description = "Datastore name"
}

variable "network_name" {
  type        = string
  description = "Portgroup / network name (the network to connect the VM NIC to)"
}

variable "template_name" {
  type        = string
  description = "Template VM name to clone from"
}

variable "vm_name" {
  type        = string
  description = "Name of the VM to create"
}

variable "cpu" {
  type        = number
  description = "vCPU count"
  default     = 2
}

variable "memory_mb" {
  type        = number
  description = "Memory in MB"
  default     = 4096
}

variable "disk_gb" {
  type        = number
  description = "Disk0 size in GB. Set 0 to keep the template disk size."
  default     = 0
}

variable "ipv4" {
  type        = string
  description = "Static IPv4 address. Leave empty for DHCP (no guest customization)."
  default     = ""
}

variable "netmask" {
  type        = number
  description = "IPv4 netmask bits (e.g., 24). Used only when ipv4 is set."
  default     = 24
}

variable "gateway" {
  type        = string
  description = "IPv4 gateway. Used only when ipv4 is set."
  default     = ""
}
