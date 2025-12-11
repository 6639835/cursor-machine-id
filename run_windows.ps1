# ============================================================
# Cursor Machine ID Changer - Windows PowerShell Script
# No dependencies required - Just double-click to run!
# ============================================================

# Set console encoding for proper display
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Function to print colored text
function Write-ColorText {
    param(
        [string]$Text,
        [string]$Color = "White"
    )
    Write-Host $Text -ForegroundColor $Color
}

# Function to print banner
function Show-Banner {
    Write-Host ""
    Write-ColorText "============================================================" "Cyan"
    Write-ColorText "        🔧 Cursor Machine ID Changer 🔧                    " "Cyan"
    Write-ColorText "        Windows PowerShell Version                          " "Cyan"
    Write-ColorText "============================================================" "Cyan"
    Write-Host ""
}

# Function to generate random hex ID (64 characters)
function New-RandomHexId {
    $guid1 = [guid]::NewGuid().ToString("N")
    $guid2 = [guid]::NewGuid().ToString("N")
    return ($guid1 + $guid2).ToLower()
}

# Function to generate UUID
function New-UUID {
    return [guid]::NewGuid().ToString().ToLower()
}

# Function to generate SQM ID
function New-SqmId {
    return "{" + [guid]::NewGuid().ToString().ToUpper() + "}"
}

# Function to check if Cursor is running
function Test-CursorRunning {
    $processes = Get-Process -Name "Cursor" -ErrorAction SilentlyContinue
    return ($null -ne $processes -and $processes.Count -gt 0)
}

# Function to backup file
function Backup-File {
    param([string]$FilePath)
    
    if (Test-Path $FilePath) {
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $backupPath = "$FilePath.backup_$timestamp"
        Copy-Item -Path $FilePath -Destination $backupPath -Force
        return $backupPath
    }
    return $null
}

# Function to get storage path
function Get-StoragePath {
    $appData = [Environment]::GetFolderPath('ApplicationData')
    return Join-Path $appData "Cursor\User\globalStorage\storage.json"
}

# Function to get main.js path
function Get-MainJsPath {
    $localAppData = [Environment]::GetFolderPath('LocalApplicationData')
    $mainJsPath = Join-Path $localAppData "Programs\cursor\resources\app\out\main.js"
    if (Test-Path $mainJsPath) {
        return $mainJsPath
    }
    return $null
}

# Function to update storage.json
function Update-StorageFile {
    param([string]$StoragePath)
    
    # Generate new IDs
    $machineId = New-RandomHexId
    $macMachineId = New-RandomHexId
    $devDeviceId = New-UUID
    $sqmId = New-SqmId
    
    # Read existing data or create new
    $data = @{}
    if (Test-Path $StoragePath) {
        try {
            $content = Get-Content -Path $StoragePath -Raw -ErrorAction Stop
            $data = $content | ConvertFrom-Json -AsHashtable -ErrorAction Stop
        }
        catch {
            Write-ColorText "⚠️  Warning: Could not read existing storage.json, creating new" "Yellow"
            $data = @{}
        }
    }
    
    # Update IDs
    $data['telemetry.machineId'] = $machineId
    $data['telemetry.macMachineId'] = $macMachineId
    $data['telemetry.devDeviceId'] = $devDeviceId
    $data['telemetry.sqmId'] = $sqmId
    
    # Ensure directory exists
    $directory = Split-Path -Parent $StoragePath
    if (-not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }
    
    # Write file
    $data | ConvertTo-Json -Depth 10 | Set-Content -Path $StoragePath -Encoding UTF8
    
    return @{
        machineId = $machineId
        macMachineId = $macMachineId
        devDeviceId = $devDeviceId
        sqmId = $sqmId
    }
}

# Function to update main.js
function Update-MainJs {
    param([string]$MainJsPath)
    
    if (-not $MainJsPath -or -not (Test-Path $MainJsPath)) {
        return $false
    }
    
    try {
        $content = Get-Content -Path $MainJsPath -Raw -Encoding UTF8
        
        # Replace REG.exe command with PowerShell GUID generation
        $oldPattern = '\$\{v5\[s\$\(\)\]\}\\REG\.exe QUERY HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Cryptography /v MachineGuid'
        $newCmd = 'powershell -Command "[guid]::NewGuid().ToString().ToLower()"'
        
        $newContent = $content -replace $oldPattern, $newCmd
        
        if ($content -ne $newContent) {
            Set-Content -Path $MainJsPath -Value $newContent -Encoding UTF8 -NoNewline
            return $true
        }
        
        return $false
    }
    catch {
        Write-ColorText "⚠️  Warning: Could not update main.js: $_" "Yellow"
        return $false
    }
}

# Function to display results
function Show-Results {
    param(
        [hashtable]$OldIds,
        [hashtable]$NewIds,
        [string]$BackupPath,
        [bool]$MainJsUpdated
    )
    
    Write-Host ""
    Write-ColorText "============================================================" "Green"
    Write-ColorText "        ✅ Successfully Changed Cursor Machine IDs!        " "Green"
    Write-ColorText "============================================================" "Green"
    Write-Host ""
    
    Write-ColorText "🔄 ID Changes:" "Cyan"
    Write-ColorText "------------------------------------------------------------" "Cyan"
    
    $idLabels = @{
        'machineId' = '📋 Machine ID'
        'macMachineId' = '📋 Mac Machine ID'
        'devDeviceId' = '📋 Device ID'
        'sqmId' = '📋 SQM ID'
    }
    
    foreach ($key in @('machineId', 'macMachineId', 'devDeviceId', 'sqmId')) {
        Write-Host ""
        Write-ColorText "$($idLabels[$key]):" "White"
        
        $oldVal = if ($OldIds.ContainsKey($key)) { $OldIds[$key] } else { "N/A" }
        $newVal = $NewIds[$key]
        
        if ($oldVal.Length -gt 50) {
            Write-ColorText "  Old: $($oldVal.Substring(0, 47))..." "Yellow"
        } else {
            Write-ColorText "  Old: $oldVal" "Yellow"
        }
        
        if ($newVal.Length -gt 50) {
            Write-ColorText "  New: $($newVal.Substring(0, 47))..." "Green"
        } else {
            Write-ColorText "  New: $newVal" "Green"
        }
    }
    
    Write-Host ""
    Write-ColorText "------------------------------------------------------------" "Cyan"
    
    if ($BackupPath) {
        $backupFileName = Split-Path -Leaf $BackupPath
        Write-ColorText "💾 Backup created: $backupFileName" "Blue"
    }
    
    if ($MainJsUpdated) {
        Write-ColorText "✅ main.js updated successfully" "Green"
    } else {
        Write-ColorText "⚠️  main.js update skipped (not found or failed)" "Yellow"
    }
    
    Write-Host ""
    Write-ColorText "============================================================" "Cyan"
    Write-ColorText "📝 Next Steps:" "Cyan"
    Write-ColorText "============================================================" "Cyan"
    Write-ColorText "  1. ✅ IDs have been changed successfully" "Green"
    Write-ColorText "  2. 🔄 Restart Cursor editor now" "Yellow"
    Write-ColorText "  3. 🔍 Check if Cursor is working properly" "Blue"
    Write-ColorText "  4. ⚠️  If issues persist: delete account and re-register" "Magenta"
    Write-ColorText "============================================================" "Cyan"
    Write-Host ""
}

# Main execution
try {
    Show-Banner
    
    # System info
    Write-ColorText "🖥️  System: Windows $([Environment]::OSVersion.Version)" "Blue"
    
    # Get paths
    $storagePath = Get-StoragePath
    $mainJsPath = Get-MainJsPath
    
    Write-ColorText "📁 Storage: $storagePath" "Blue"
    if ($mainJsPath) {
        Write-ColorText "📄 Main.js: $mainJsPath" "Blue"
    }
    Write-Host ""
    
    # Check if Cursor is running
    if (Test-CursorRunning) {
        Write-Host ""
        Write-ColorText "============================================================" "Red"
        Write-ColorText "        ⚠️  WARNING: Cursor is Currently Running!           " "Red"
        Write-ColorText "============================================================" "Red"
        Write-Host ""
        Write-ColorText "❌ Please close Cursor editor before changing IDs!" "Red"
        Write-ColorText "   Then run this script again." "Yellow"
        Write-Host ""
        Read-Host "Press Enter to exit"
        exit 1
    }
    
    # Read current IDs
    $oldIds = @{}
    if (Test-Path $storagePath) {
        try {
            $content = Get-Content -Path $storagePath -Raw
            $data = $content | ConvertFrom-Json -AsHashtable
            $oldIds = @{
                machineId = $data['telemetry.machineId']
                macMachineId = $data['telemetry.macMachineId']
                devDeviceId = $data['telemetry.devDeviceId']
                sqmId = $data['telemetry.sqmId']
            }
        }
        catch {
            # Ignore errors reading old IDs
        }
    }
    
    Write-ColorText "⏳ Processing..." "Yellow"
    Write-ColorText "  • Creating backup..." "Cyan"
    
    # Backup storage file
    $backupPath = Backup-File -FilePath $storagePath
    if ($backupPath) {
        Write-ColorText "  ✅ Backup created" "Green"
    }
    
    # Update IDs
    Write-ColorText "  • Generating new IDs..." "Cyan"
    $newIds = Update-StorageFile -StoragePath $storagePath
    Write-ColorText "  ✅ New IDs generated" "Green"
    
    # Update main.js if available
    $mainJsUpdated = $false
    if ($mainJsPath) {
        Write-ColorText "  • Updating main.js..." "Cyan"
        $mainJsBackup = Backup-File -FilePath $mainJsPath
        $mainJsUpdated = Update-MainJs -MainJsPath $mainJsPath
        if ($mainJsUpdated) {
            Write-ColorText "  ✅ main.js updated" "Green"
        }
    }
    
    # Display results
    Show-Results -OldIds $oldIds -NewIds $newIds -BackupPath $backupPath -MainJsUpdated $mainJsUpdated
    
    Write-ColorText "✨ Done! You can now restart Cursor." "Green"
    Write-Host ""
}
catch {
    Write-Host ""
    Write-ColorText "============================================================" "Red"
    Write-ColorText "❌ Error: $_" "Red"
    Write-ColorText "============================================================" "Red"
    Write-Host ""
}

# Keep window open
Read-Host "`nPress Enter to exit"
