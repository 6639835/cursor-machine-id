<div align="center">

<img src="https://raw.githubusercontent.com/PKief/vscode-material-icon-theme/main/icons/wrench.svg" width="120" height="120" alt="Cursor Machine ID Changer Icon">

# Cursor Machine ID Changer v1.0.0

**A modern, cross-platform tool to reset Cursor editor device IDs**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](https://github.com)

[English](#english)

</div>

---

## English

### Features

- **Beautiful Colorful Output** - Modern, colorful terminal UI with progress indicators
- **Double-Click to Run** - Simple launcher scripts for all platforms
- **Automatic ID Generation** - Generates properly formatted random device IDs
- **Smart Backup System** - Automatically backs up original configuration
- **Process Detection** - Warns if Cursor is running (requires `psutil`)
- **Before/After Comparison** - Shows old vs new IDs in a clear table
- **Interactive & Automatic Modes** - Choose your preferred workflow
- **Cross-Platform** - Supports Windows, macOS, and Linux

### What's Included

```
cursor-machine-id/
├── STANDALONE SCRIPTS (No Python Required!)
│   ├── change_cursor_id_windows.ps1   # Windows PowerShell
│   ├── change_cursor_id_mac.command   # macOS Bash
│   └── change_cursor_id_linux.sh      # Linux Bash
│
├── PYTHON-BASED SCRIPTS (Legacy)
│   ├── quick_change.py                # Quick auto-run script
│   ├── cursor_id_changer.py           # Advanced interactive version
│   ├── run_mac.command                # macOS Python launcher
│   ├── run_windows.bat                # Windows Python launcher
│   └── run_linux.sh                   # Linux Python launcher
│
├── requirements.txt         # Python dependencies (for Python scripts)
├── README.md                # This file
└── LICENSE                  # MIT License
```

### Quick Start

#### **Method 1: Standalone Scripts (RECOMMENDED - No Dependencies!)**

**NEW: Zero dependencies - Just double-click and run!**

These native scripts require NO Python installation and work out of the box:

1. **Windows:** 
   - Right-click `change_cursor_id_windows.ps1`
   - Select "Run with PowerShell"
   - (Or double-click if PowerShell is default)

2. **macOS:** 
   - Double-click `change_cursor_id_mac.command`
   - (May need to right-click → Open the first time)

3. **Linux:** 
   - Double-click `change_cursor_id_linux.sh`
   - (Or run `./change_cursor_id_linux.sh` in terminal)

**Features:**
- No Python installation required
- No dependencies to install
- Beautiful colored output
- Automatic backups
- Process detection
- Before/after comparison
- Works on fresh systems

That's it! The script will automatically change your IDs and show colorful results.

#### **Method 2: Python Quick Change (Requires Python)**

**For users who already have Python installed:**

1. **Windows:** Double-click `run_windows.bat`
2. **macOS:** Double-click `run_mac.command`
3. **Linux:** Double-click `run_linux.sh` (or run `./run_linux.sh`)

Or use the Python script directly:

```bash
# Just run - no prompts, automatic execution
python3 quick_change.py
```

#### **Method 3: Python Interactive Mode (Advanced)**

For users who want more control and features:

```bash
# Interactive mode with menu
python3 cursor_id_changer.py

# Or use command-line options
python3 cursor_id_changer.py --auto        # Auto mode
python3 cursor_id_changer.py --list-backups  # List backups
python3 cursor_id_changer.py --verbose     # Verbose output
python3 cursor_id_changer.py --dry-run     # Preview without applying
```

### Installation

#### Option 1: Standalone Scripts (NO INSTALLATION NEEDED!)

**RECOMMENDED for most users**

The standalone scripts require ZERO dependencies:
- No Python installation needed
- No pip packages to install
- Just download and run!

Simply download these files and run:
- Windows: `change_cursor_id_windows.ps1`
- macOS: `change_cursor_id_mac.command`
- Linux: `change_cursor_id_linux.sh`

#### Option 2: Python-Based Scripts (Requires Python)

**Prerequisites:**
- Python 3.8 or higher (Download from [python.org](https://www.python.org/downloads/))
- pip (Usually included with Python)

**Install Dependencies (Optional but Recommended):**

```bash
# Install all dependencies for the best experience
pip install -r requirements.txt

# Or install individually
pip install rich psutil
```

**Note:** The Python scripts work without dependencies, but you'll get:
- Beautiful colored output with `rich`
- Process detection with `psutil`

### Usage Examples

#### Example 1: Standalone Script (Recommended - No Python!)

**Windows (PowerShell):**
```powershell
# Right-click → Run with PowerShell
# Or from PowerShell:
.\change_cursor_id_windows.ps1
```

**macOS:**
```bash
# Double-click or:
./change_cursor_id_mac.command
```

**Linux:**
```bash
# Double-click or:
./change_cursor_id_linux.sh
```

#### Example 2: Python Quick Change

```bash
python3 quick_change.py
```

Output:
```
======================================================================
        Cursor Machine ID Quick Changer        
======================================================================

System: macOS 14.0
Storage: /Users/user/Library/Application Support/Cursor/...
Processing...
  • Creating backup...
  ✓ Backup created
  • Generating new IDs...
  ✓ New IDs generated
  • Updating main.js...
  ✓ main.js updated

======================================================================
        Successfully Changed Cursor Machine IDs!        
======================================================================

ID Changes:
----------------------------------------------------------------------

Machine ID:
  Old: 1234567890abcdef...
  New: fedcba0987654321...

[... more IDs ...]

Backup created: storage.json.backup_20231211_143052
main.js updated successfully

======================================================================
Next Steps:
======================================================================
  1. IDs have been changed successfully
  2. Restart Cursor editor now
  3. Check if Cursor is working properly
  4. If issues persist: delete account and re-register
======================================================================

Done! You can now restart Cursor.
```

#### Example 3: Interactive Mode with Rich UI

```bash
python3 cursor_id_changer.py
```

Provides a beautiful menu with:
- Change IDs
- List backups
- Restore from backup
- All with colorful tables and panels

#### Example 4: Command Line Options

```bash
# List all backups
python3 cursor_id_changer.py --list-backups

# Auto mode (no interaction)
python3 cursor_id_changer.py --auto

# Preview changes without applying
python3 cursor_id_changer.py --dry-run

# Verbose output for debugging
python3 cursor_id_changer.py --verbose
```

### How It Works

The tool modifies the following device identifiers in Cursor's configuration:

- `telemetry.machineId` - Primary machine identifier (64-char hex)
- `telemetry.macMachineId` - Mac-specific identifier (64-char hex)
- `telemetry.devDeviceId` - Device UUID
- `telemetry.sqmId` - Software Quality Metrics ID (Windows)

Additionally, on macOS and Windows (v0.45.x+), it updates `main.js` to generate random UUIDs instead of using hardware-based IDs.

### Configuration File Locations

#### Windows
```
%APPDATA%\Cursor\User\globalStorage\storage.json
%LOCALAPPDATA%\Programs\cursor\resources\app\out\main.js
```

#### macOS
```
~/Library/Application Support/Cursor/User/globalStorage/storage.json
/Applications/Cursor.app/Contents/Resources/app/out/main.js
```

#### Linux
```
~/.config/Cursor/User/globalStorage/storage.json
```

### Important Notes

1. **Close Cursor First** - Always close Cursor editor before running the script
2. **Automatic Backups** - Original files are backed up with timestamps
3. **Safe to Use** - Can restore from backups if needed
4. **Restart Required** - Restart Cursor after changing IDs
5. **Account Issues** - If problems persist, delete account and re-register

### Troubleshooting

#### Standalone Scripts Issues

**Windows PowerShell Execution Policy:**
```powershell
# If you get "cannot be loaded because running scripts is disabled"
# Run PowerShell as Administrator and execute:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Then try running the script again
```

**macOS "Cannot be opened" Error:**
```bash
# Right-click the file → Open (instead of double-clicking)
# Or run in Terminal:
chmod +x change_cursor_id_mac.command
./change_cursor_id_mac.command
```

**Linux Permission Denied:**
```bash
chmod +x change_cursor_id_linux.sh
./change_cursor_id_linux.sh
```

#### Python Scripts Issues

**Python Not Found:**
```bash
# Install Python 3.8+
# Windows: Download from python.org
# macOS: brew install python3
# Linux: sudo apt install python3
```

**Permission Denied (Python Launchers):**
```bash
chmod +x run_mac.command  # or run_linux.sh
```

#### Cursor Still Shows Old ID
1. Completely close Cursor (check system tray/menu bar)
2. Run the script again
3. Restart Cursor
4. If still failing, try deleting account and re-registering

#### Script Doesn't Run on macOS
```bash
# Right-click run_mac.command → Open
# Or run in Terminal:
./run_mac.command
```

### Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Disclaimer

**This tool is for educational and research purposes only.** Using this tool may violate Cursor's Terms of Service. Use at your own risk. The authors are not responsible for any issues arising from the use of this tool.

### Credits

- Original concept from [fly8888/cursor_machine_id](https://github.com/fly8888/cursor_machine_id)
- Rewritten and modernized with colorful output and better UX
- Uses [Rich](https://github.com/Textualize/rich) for beautiful terminal output

---

<div align="center">

**Made with care for the Cursor community**

[Back to Top](#cursor-machine-id-changer-v100)

</div>
