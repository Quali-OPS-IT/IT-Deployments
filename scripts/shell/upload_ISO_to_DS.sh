#!/bin/bash
set -e  # Exit immediately if a command fails

# --- 1. INPUT VALIDATION ---
# We check if Torque provided all the necessary inputs.
# If any are missing, we print an error and exit.

: "${VC_USER:?Variable VC_USER not set (Secrets)}"
: "${VC_PASS:?Variable VC_PASS not set (Secrets)}"
: "${VC_URL:?Variable VC_URL not set}"
: "${DC_NAME:?Variable DC_NAME (Datacenter) not set}"
: "${DS_NAME:?Variable DS_NAME (Datastore) not set}"
: "${ISO_NAME:?Variable ISO_NAME not set}"
: "${REMOTE_FOLDER:?Variable REMOTE_FOLDER (e.g., IT.ISO) not set}"

# Optional: Default local path if not provided
LOCAL_PATH="${LOCAL_PATH:-/opt/torque/images/$ISO_NAME}"

echo "🔧 Starting Staging Workflow for: $ISO_NAME"
echo "📍 Target: Datacenter [$DC_NAME] -> Datastore [$DS_NAME] -> Folder [$REMOTE_FOLDER]"

# --- 2. GOVC SETUP ---
# Auto-install govc if it's missing on the agent
if ! command -v govc &> /dev/null; then
    echo "⬇️ govc not found. Installing..."
    curl -L -o - "https://github.com/vmware/govmomi/releases/latest/download/govc_$(uname -s)_$(uname -m).tar.gz" | tar -C /usr/local/bin -xvzf - govc
fi

# Configure GOVC environment variables
export GOVC_URL="https://$VC_USER:$VC_PASS@$VC_URL/sdk"
export GOVC_INSECURE=true
export GOVC_DATACENTER="$DC_NAME"  # <--- Critical fix from our testing (SandBox)

# --- 3. IDEMPOTENCY CHECK ---
# We check if the file already exists to avoid re-uploading 5GB files unnecessarily.

REMOTE_PATH="$REMOTE_FOLDER/$ISO_NAME"

echo "🔍 Checking if $REMOTE_PATH exists..."

if govc datastore.ls -ds "$DS_NAME" "$REMOTE_PATH" > /dev/null 2>&1; then
    echo "✅ ISO already exists on datastore. Skipping upload."
else
    echo "🚀 ISO not found. Starting upload..."
    
    # Ensure the remote folder exists (silence error if it already does)
    govc datastore.mkdir -ds "$DS_NAME" "$REMOTE_FOLDER" 2>/dev/null || true
    
    # Upload the file
    govc datastore.upload -ds "$DS_NAME" "$LOCAL_PATH" "$REMOTE_PATH"
    echo "✅ Upload complete."
fi

# --- 4. TORQUE OUTPUT ---
# Pass the final path back to Torque (so Terraform can use it later)
# We handle the case where TORQUE_OUTPUT_FILE might not be set (manual testing)
if [ -n "$TORQUE_OUTPUT_FILE" ]; then
    echo "remote_iso_path=$REMOTE_PATH" > "$TORQUE_OUTPUT_FILE"
    echo "📤 Output 'remote_iso_path' set to: $REMOTE_PATH"
fi