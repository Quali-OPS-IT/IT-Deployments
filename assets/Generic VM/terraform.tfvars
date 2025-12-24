# --- vCenter access ---
vcenter_server        = "sandbox.qualisystems.local"
vcenter_user          = "Administrator@vsphere.local"
vcenter_password      = "g{/E/U64x+s%W9xY~,OM"
allow_unverified_ssl  = true

# --- Inventory location ---
datacenter    = "SandBox"
resource_pool = "/SandBox/host/192.168.42.113/Resources"

# --- Storage / Network / Template (must match vCenter exactly) ---
datastore     = "Lab-datastore"
network_name  = "Vlan 65 (General Use)"
template_name = "/SandBox/vm/Clean Templates (Do Not Change, only IT)/Ubuntu 24.04.2 LTS"

# --- VM settings ---
vm_name   = "tf-test-vm-01"
cpu       = 2
memory_mb = 4096
disk_gb   = 0   # 0 = keep template disk size

# --- Networking inside guest ---
ipv4    = ""    # empty = DHCP (no guest customization)
netmask = 24
gateway = ""
