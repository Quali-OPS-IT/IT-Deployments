variable "region" {
  type        = string
  description = "AWS region."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the EC2 instance."
}

variable "os_image" {
  type        = string
  description = "Curated OS image choice."
  validation {
    condition = contains([
      "amazonlinux2",
      "amazonlinux2023",

      "ubuntu2004",
      "ubuntu2204",
      "ubuntu2404",

      "debian11",
      "debian12",

      "windows2019full",
      "windows2022full",
      "windows2022core"
    ], var.os_image)
    error_message = "os_image must be one of the supported curated values."
  }
}

variable "architecture" {
  type        = string
  description = "CPU architecture for the AMI selection: x86_64 or arm64."
  default     = "x86_64"

  validation {
    condition     = contains(["x86_64", "arm64"], var.architecture)
    error_message = "architecture must be x86_64 or arm64."
  }
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type (e.g., t3.micro, m7g.large)."
  default     = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "Optional EC2 key pair name for SSH/RDP."
  default     = null
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether to associate a public IPv4 address."
  default     = true
}

variable "create_security_group" {
  type        = bool
  description = "If true, create a Security Group and attach it to the instance."
  default     = true
}

variable "security_group_ids" {
  type        = list(string)
  description = "Additional or pre-existing Security Group IDs to attach."
  default     = []
}

variable "allowed_cidrs" {
  type        = list(string)
  description = "CIDR blocks allowed for inbound access (used when inbound_ports is non-empty)."
  default     = []
}

variable "inbound_ports" {
  type        = list(number)
  description = "Inbound TCP ports to open from allowed_cidrs (e.g., [22, 3389])."
  default     = []
}

variable "root_volume_size" {
  type        = number
  description = "Root volume size in GiB."
  default     = 30
}

variable "root_volume_type" {
  type        = string
  description = "Root volume type (e.g., gp3, gp2)."
  default     = "gp3"
}

variable "root_volume_encrypted" {
  type        = bool
  description = "Whether to encrypt the root EBS volume."
  default     = true
}

variable "user_data" {
  type        = string
  description = "Optional user_data to pass to the instance."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources."
  default     = {}
}
