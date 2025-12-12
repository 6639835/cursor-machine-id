# Cursor Machine ID Changer

**A simple, cross-platform tool to reset Cursor editor device IDs**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](https://github.com)


</div>

---

## English

### Features

- **No Dependencies** - Native scripts require no Python or additional packages
- **Beautiful Colorful Output** - Modern, colorful terminal UI with progress indicators
- **Double-Click to Run** - Simple launcher scripts for all platforms
- **Automatic ID Generation** - Generates properly formatted random device IDs
- **Smart Backup System** - Automatically backs up original configuration
- **Process Detection** - Warns if Cursor is running
- **Before/After Comparison** - Shows old vs new IDs in a clear table
- **Cross-Platform** - Supports Windows, macOS, and Linux

### What's Included

```
cursor-machine-id/
├── run_windows.ps1          # Windows PowerShell script
├── run_mac.command          # macOS Bash script
├── run_linux.sh             # Linux Bash script
├── README.md                # This file
├── LICENSE                  # MIT License
└── .gitignore               # Git ignore file
```

### Quick Start

**Zero dependencies - Just double-click and run!**

These native scripts require NO Python installation and work out of the box:

1. **Windows:**
   - Right-click `run_windows.ps1`
   - Select "Run with PowerShell"
   - (Or double-click if PowerShell is default)

2. **macOS:**
   - Double-click `run_mac.command`
   - (May need to right-click → Open the first time)

3. **Linux:**
   - Double-click `run_linux.sh`
   - (Or run `./run_linux.sh` in terminal)

**Features:**
- No Python installation required
- No dependencies to install
- Beautiful colored output
- Automatic backups
- Process detection
- Before/after comparison
- Works on fresh systems

That's it! The script will automatically change your IDs and show colorful results.

### Installation

**NO INSTALLATION NEEDED!**

The scripts require ZERO dependencies:
- No Python installation needed
- No packages to install
- Just download and run!

Simply download these files and run:
- Windows: `run_windows.ps1`
- macOS: `run_mac.command`
- Linux: `run_linux.sh`

### Usage Examples

**Windows (PowerShell):**
```powershell
# Right-click → Run with PowerShell
# Or from PowerShell:
.\run_windows.ps1
```

**macOS:**
```bash
# Double-click or:
./run_mac.command
```

**Linux:**
```bash
# Double-click or:
./run_linux.sh
```

### Sample Output

```
============================================================
        Cursor Machine ID Changer
        Windows PowerShell Version
============================================================

System: Windows 11
Storage: C:\Users\user\AppData\Roaming\Cursor\...
Processing...
  - Creating backup...
  - Backup created
  - Generating new IDs...
  - New IDs generated
  - Updating main.js...
  - main.js updated

============================================================
        Successfully Changed Cursor Machine IDs!
============================================================

ID Changes:
------------------------------------------------------------

Machine ID:
  Old: 1234567890abcdef...
  New: fedcba0987654321...

[... more IDs ...]

Backup created: storage.json.backup_20231211_143052
main.js updated successfully

============================================================
Next Steps:
============================================================
  1. IDs have been changed successfully
  2. Restart Cursor editor now
  3. Check if Cursor is working properly
  4. If issues persist: delete account and re-register
============================================================

Done! You can now restart Cursor.
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
chmod +x run_mac.command
./run_mac.command
```

**Linux Permission Denied:**
```bash
chmod +x run_linux.sh
./run_linux.sh
```

**Cursor Still Shows Old ID:**
1. Completely close Cursor (check system tray/menu bar)
2. Run the script again
3. Restart Cursor
4. If still failing, try deleting account and re-registering

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
