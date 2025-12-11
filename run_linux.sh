#!/bin/bash
# ============================================================
# Cursor Machine ID Changer - Linux Bash Script
# No dependencies required - Just run this script!
# ============================================================

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
    # Use /dev/urandom to generate random hex
    cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 64 | head -n 1
}

# Function to generate UUID
generate_uuid() {
    # Try using uuidgen if available, otherwise generate manually
    if command -v uuidgen &> /dev/null; then
        uuidgen | tr '[:upper:]' '[:lower:]'
    else
        # Generate UUID manually
        local N B T
        for (( N=0; N < 16; ++N )); do
            B=$(( RANDOM % 256 ))
            if (( N == 6 )); then
                printf '4%x' $(( B % 16 ))
            elif (( N == 8 )); then
                local A=$(( B % 4 ))
                printf '%x' $(( A + 8 ))$(( B % 16 ))
            else
                printf '%02x' $B
            fi
            case $N in
                3 | 5 | 7 | 9)
                    printf '-'
                    ;;
            esac
        done
        echo
    fi
}

# Function to generate SQM ID
generate_sqm_id() {
    echo "{$(generate_uuid | tr '[:lower:]' '[:upper:]')}"
}

# Function to check if Cursor is running
is_cursor_running() {
    if pgrep -x "cursor" > /dev/null 2>&1; then
        return 0
    fi
    
    if pgrep -x "Cursor" > /dev/null 2>&1; then
        return 0
    fi
    
    if pgrep -x "cursor-bin" > /dev/null 2>&1; then
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
    echo "$HOME/.config/Cursor/User/globalStorage/storage.json"
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
        python3 -c "import json, sys; data=json.load(open('$file')); print(data.get('$key', 'N/A'))" 2>/dev/null || echo "N/A"
    else
        # Fallback to grep/sed
        grep "\"$key\"" "$file" 2>/dev/null | sed 's/.*: "\(.*\)".*/\1/' | head -1 || echo "N/A"
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
    if '''$existing_data''':
        data = json.loads('''$existing_data''')
    else:
        data = {}
except:
    data = {}

data['telemetry.machineId'] = '''$machine_id'''
data['telemetry.macMachineId'] = '''$mac_machine_id'''
data['telemetry.devDeviceId'] = '''$dev_device_id'''
data['telemetry.sqmId'] = '''$sqm_id'''

with open('''$storage_path''', 'w') as f:
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
echo -e "${CYAN}${BOLD}        Linux Bash Version                                 ${NC}"
echo -e "${CYAN}============================================================${NC}"
echo ""

# System info
echo -e "${BLUE}🖥️  System: Linux $(uname -r)${NC}"

# Get paths
STORAGE_PATH=$(get_storage_path)

echo -e "${BLUE}📁 Storage: $STORAGE_PATH${NC}"
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

# Keep terminal open if running in terminal
read -p "Press Enter to exit..."
