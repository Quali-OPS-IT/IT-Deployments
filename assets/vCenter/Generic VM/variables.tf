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
  type        = bool
  description = "Allow insecure SSL for vCenter"
  default     = true
}

variable "datacenter" {
  type        = string
  description = "vSphere Datacenter name"
}

variable "cluster" {
  type        = string
  description = "vSphere Cluster name (used if resource_pool is not provided)"
  default     = ""
}

variable "resource_pool" {
  type        = string
  description = "Optional: full resource pool path/name. If set, overrides cluster default resource pool."
  default     = ""
}

variable "datastore" {
  type        = string
  description = "Datastore name"
}

variable "network_name" {
  type        = string
  description = "Portgroup / Network name"
}

variable "template_name" {
  type        = string
  description = "Template VM name to clone from"
}

variable "folder" {
  type        = string
  description = "Optional VM folder path in vCenter (e.g. /DC/vm/Workloads). Leave empty to use default."
  default     = ""
}

variable "vm_name" {
  type        = string
  description = "VM name to create"
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
  description = "Primary disk size in GB (resizes disk0)"
  default     = 50
}

# Networking: if ipv4 is empty => no guest customization (DHCP assumed)
variable "ipv4" {
  type        = string
  description = "Static IPv4 address. Leave empty for DHCP/no customization."
  default     = ""
}

variable "netmask" {
  type        = number
  description = "CIDR bits, e.g. 24 (only used for static)"
  default     = 24
}

variable "gateway" {
  type        = string
  description = "IPv4 gateway (only used for static)"
  default     = ""
}

variable "dns_servers" {
  type        = string
  description = "Comma-separated DNS servers (only used for static), e.g. 1.1.1.1,8.8.8.8"
  default     = ""
}

variable "domain" {
  type        = string
  description = "DNS domain for linux guest customization (optional)"
  default     = ""
}

variable "hostname" {
  type        = string
  description = "Hostname for linux guest customization (optional). If empty, uses vm_name (sanitized/truncated)."
  default     = ""
}

variable "wait_for_guest_net_timeout" {
  type        = number
  description = "Seconds to wait for guest networking/IP reporting (VMware Tools required)."
  default     = 600
}
