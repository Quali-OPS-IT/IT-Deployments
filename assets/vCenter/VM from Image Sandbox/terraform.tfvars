vm_name      = "terraform-test-wsl-dor"
datacenter   = "Datacenter-Name"   # Check vCenter for exact name
datastore    = "Datastore-Name"    # e.g., vsanDatastore or local-01
cluster      = "Cluster-Name"      # e.g., Cluster-01
network      = "VM Network"        # The port group name
folder       = ""                  # Optional: Leave empty or provide a folder name

# Optional: Override the Ubuntu URL if you have a local web server
# ova_url    = "http://internal-server/image.ova"