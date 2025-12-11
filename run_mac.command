#!/bin/bash
# ============================================================
# Cursor Machine ID Changer - macOS Bash Script
# No dependencies required - Just double-click to run!
# ============================================================

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to generate random hex ID (64 characters)
generate_random_hex_id() {
    local hex1=$(uuidgen | tr -d '-' | tr '[:upper:]' '[:lower:]')
    local hex2=$(uuidgen | tr -d '-' | tr '[:upper:]' '[:lower:]')
    echo "${hex1}${hex2}"
}

# Function to generate UUID
generate_uuid() {
    uuidgen | tr '[:upper:]' '[:lower:]'
}

# Function to generate SQM ID
generate_sqm_id() {
    echo "{$(uuidgen)}"
}

# Function to check if Cursor is running
is_cursor_running() {
    if pgrep -x "Cursor" > /dev/null 2>&1; then
        return 0
    fi
    
    # Also check for Cursor processes in the app bundle
    if ps aux | grep -v grep | grep "/Applications/Cursor.app" | grep -v "Helper" > /dev/null 2>&1; then
        return 0
    fi
    
    return 1
}

# Function to backup file
backup_file() {
    local file_path="$1"
    
    if [ -f "$file_path" ]; then
        local timestamp=$(date +"%Y%m%d_%H%M%S")
        local backup_path="${file_path}.backup_${timestamp}"
        cp "$file_path" "$backup_path"
        echo "$backup_path"
    fi
}

# Function to get storage path
get_storage_path() {
    echo "$HOME/Library/Application Support/Cursor/User/globalStorage/storage.json"
}

# Function to get main.js path
get_main_js_path() {
    local main_js_path="/Applications/Cursor.app/Contents/Resources/app/out/main.js"
    if [ -f "$main_js_path" ]; then
        echo "$main_js_path"
    fi
}

# Function to read JSON value
read_json_value() {
    local file="$1"
    local key="$2"
    
    if [ ! -f "$file" ]; then
        echo "N/A"
        return
    fi
    
    # Use Python if available for better JSON parsing, otherwise use grep/sed
    if command -v python3 &> /dev/null; then
        python3 -c "import json, sys; data=json.load(open('$file')); print(data.get('$key', 'N/A'))"
    else
        # Fallback to grep/sed
        grep "\"$key\"" "$file" | sed 's/.*: "\(.*\)".*/\1/' | head -1
    fi
}

# Function to update storage.json
update_storage_file() {
    local storage_path="$1"
    local machine_id="$2"
    local mac_machine_id="$3"
    local dev_device_id="$4"
    local sqm_id="$5"
    
    # Ensure directory exists
    local directory=$(dirname "$storage_path")
    mkdir -p "$directory"
    
    # Read existing data or create new
    local existing_data=""
    if [ -f "$storage_path" ]; then
        existing_data=$(cat "$storage_path")
    fi
    
    # Create JSON with new IDs
    # Use Python if available for proper JSON handling
    if command -v python3 &> /dev/null; then
        python3 << EOF
import json
import sys

try:
    if '$existing_data':
        data = json.loads('$existing_data')
    else:
        data = {}
except:
    data = {}

data['telemetry.machineId'] = '$machine_id'
data['telemetry.macMachineId'] = '$mac_machine_id'
data['telemetry.devDeviceId'] = '$dev_device_id'
data['telemetry.sqmId'] = '$sqm_id'

with open('$storage_path', 'w') as f:
    json.dump(data, f, indent=4)
EOF
    else
        # Fallback: create simple JSON structure
        cat > "$storage_path" << EOF
{
    "telemetry.machineId": "$machine_id",
    "telemetry.macMachineId": "$mac_machine_id",
    "telemetry.devDeviceId": "$dev_device_id",
    "telemetry.sqmId": "$sqm_id"
}
EOF
    fi
}

# Function to update main.js
update_main_js() {
    local main_js_path="$1"
    
    if [ ! -f "$main_js_path" ]; then
        return 1
    fi
    
    # Replace ioreg command with UUID generation
    sed -i '' 's/ioreg -rd1 -c IOPlatformExpertDevice/UUID=$(uuidgen | tr '\''[:upper:]'\'' '\''[:lower:]'\'');echo \\"IOPlatformUUID = \\"$UUID\\";/g' "$main_js_path" 2>/dev/null
    
    return $?
}

# Function to truncate string
truncate_string() {
    local str="$1"
    local max_len="${2:-50}"
    
    if [ ${#str} -gt $max_len ]; then
        echo "${str:0:$((max_len-3))}..."
    else
        echo "$str"
    fi
}

# Print banner
clear
echo ""
echo -e "${CYAN}============================================================${NC}"
echo -e "${CYAN}${BOLD}        🔧 Cursor Machine ID Changer 🔧                    ${NC}"
echo -e "${CYAN}${BOLD}        macOS Bash Version                                 ${NC}"
echo -e "${CYAN}============================================================${NC}"
echo ""

# System info
echo -e "${BLUE}🖥️  System: macOS $(sw_vers -productVersion)${NC}"

# Get paths
STORAGE_PATH=$(get_storage_path)
MAIN_JS_PATH=$(get_main_js_path)

echo -e "${BLUE}📁 Storage: $STORAGE_PATH${NC}"
if [ -n "$MAIN_JS_PATH" ]; then
    echo -e "${BLUE}📄 Main.js: $MAIN_JS_PATH${NC}"
fi
echo ""

# Check if Cursor is running
if is_cursor_running; then
    echo ""
    echo -e "${RED}============================================================${NC}"
    echo -e "${RED}${BOLD}        ⚠️  WARNING: Cursor is Currently Running!           ${NC}"
    echo -e "${RED}============================================================${NC}"
    echo ""
    echo -e "${RED}❌ Please close Cursor editor before changing IDs!${NC}"
    echo -e "${YELLOW}   Then run this script again.${NC}"
    echo ""
    read -p "Press Enter to exit..."
    exit 1
fi

# Read current IDs
OLD_MACHINE_ID=$(read_json_value "$STORAGE_PATH" "telemetry.machineId")
OLD_MAC_MACHINE_ID=$(read_json_value "$STORAGE_PATH" "telemetry.macMachineId")
OLD_DEV_DEVICE_ID=$(read_json_value "$STORAGE_PATH" "telemetry.devDeviceId")
OLD_SQM_ID=$(read_json_value "$STORAGE_PATH" "telemetry.sqmId")

# Processing
echo -e "${YELLOW}⏳ Processing...${NC}"
echo -e "${CYAN}  • Creating backup...${NC}"

# Backup storage file
BACKUP_PATH=$(backup_file "$STORAGE_PATH")
if [ -n "$BACKUP_PATH" ]; then
    echo -e "${GREEN}  ✅ Backup created${NC}"
fi

# Generate new IDs
echo -e "${CYAN}  • Generating new IDs...${NC}"
NEW_MACHINE_ID=$(generate_random_hex_id)
NEW_MAC_MACHINE_ID=$(generate_random_hex_id)
NEW_DEV_DEVICE_ID=$(generate_uuid)
NEW_SQM_ID=$(generate_sqm_id)

# Update storage file
update_storage_file "$STORAGE_PATH" "$NEW_MACHINE_ID" "$NEW_MAC_MACHINE_ID" "$NEW_DEV_DEVICE_ID" "$NEW_SQM_ID"
echo -e "${GREEN}  ✅ New IDs generated${NC}"

# Update main.js if available
MAIN_JS_UPDATED=false
if [ -n "$MAIN_JS_PATH" ] && [ -f "$MAIN_JS_PATH" ]; then
    echo -e "${CYAN}  • Updating main.js...${NC}"
    MAIN_JS_BACKUP=$(backup_file "$MAIN_JS_PATH")
    if update_main_js "$MAIN_JS_PATH"; then
        echo -e "${GREEN}  ✅ main.js updated${NC}"
        MAIN_JS_UPDATED=true
    fi
fi

# Display results
echo ""
echo -e "${GREEN}============================================================${NC}"
echo -e "${GREEN}${BOLD}        ✅ Successfully Changed Cursor Machine IDs!        ${NC}"
echo -e "${GREEN}============================================================${NC}"
echo ""

echo -e "${CYAN}🔄 ID Changes:${NC}"
echo -e "${CYAN}------------------------------------------------------------${NC}"

# Machine ID
echo ""
echo -e "${WHITE}${BOLD}📋 Machine ID:${NC}"
echo -e "${YELLOW}  Old: $(truncate_string "$OLD_MACHINE_ID")${NC}"
echo -e "${GREEN}  New: $(truncate_string "$NEW_MACHINE_ID")${NC}"

# Mac Machine ID
echo ""
echo -e "${WHITE}${BOLD}📋 Mac Machine ID:${NC}"
echo -e "${YELLOW}  Old: $(truncate_string "$OLD_MAC_MACHINE_ID")${NC}"
echo -e "${GREEN}  New: $(truncate_string "$NEW_MAC_MACHINE_ID")${NC}"

# Device ID
echo ""
echo -e "${WHITE}${BOLD}📋 Device ID:${NC}"
echo -e "${YELLOW}  Old: $(truncate_string "$OLD_DEV_DEVICE_ID")${NC}"
echo -e "${GREEN}  New: $(truncate_string "$NEW_DEV_DEVICE_ID")${NC}"

# SQM ID
echo ""
echo -e "${WHITE}${BOLD}📋 SQM ID:${NC}"
echo -e "${YELLOW}  Old: $(truncate_string "$OLD_SQM_ID")${NC}"
echo -e "${GREEN}  New: $(truncate_string "$NEW_SQM_ID")${NC}"

echo ""
echo -e "${CYAN}------------------------------------------------------------${NC}"

# Backup info
if [ -n "$BACKUP_PATH" ]; then
    BACKUP_FILENAME=$(basename "$BACKUP_PATH")
    echo -e "${BLUE}💾 Backup created: $BACKUP_FILENAME${NC}"
fi

# Main.js status
if [ "$MAIN_JS_UPDATED" = true ]; then
    echo -e "${GREEN}✅ main.js updated successfully${NC}"
else
    echo -e "${YELLOW}⚠️  main.js update skipped (not found or failed)${NC}"
fi

# Next steps
echo ""
echo -e "${CYAN}============================================================${NC}"
echo -e "${CYAN}${BOLD}📝 Next Steps:${NC}"
echo -e "${CYAN}============================================================${NC}"
echo -e "${GREEN}  1. ✅ IDs have been changed successfully${NC}"
echo -e "${YELLOW}  2. 🔄 Restart Cursor editor now${NC}"
echo -e "${BLUE}  3. 🔍 Check if Cursor is working properly${NC}"
echo -e "${MAGENTA}  4. ⚠️  If issues persist: delete account and re-register${NC}"
echo -e "${CYAN}============================================================${NC}"
echo ""

echo -e "${GREEN}${BOLD}✨ Done! You can now restart Cursor.${NC}"
echo ""

# Keep window open
read -p "Press Enter to exit..."
