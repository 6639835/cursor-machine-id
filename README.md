# 🔧 Cursor Machine ID Changer v2.0

<div align="center">

**A modern, cross-platform tool to reset Cursor editor device IDs**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](https://github.com)

[English](#english) | [中文文档](#中文文档)

</div>

---

## English

### ✨ Features

- 🎨 **Beautiful Colorful Output** - Modern, colorful terminal UI with progress indicators
- 🖱️ **Double-Click to Run** - Simple launcher scripts for all platforms
- 🔄 **Automatic ID Generation** - Generates properly formatted random device IDs
- 💾 **Smart Backup System** - Automatically backs up original configuration
- 🛡️ **Process Detection** - Warns if Cursor is running (requires `psutil`)
- 📊 **Before/After Comparison** - Shows old vs new IDs in a clear table
- 🎮 **Interactive & Automatic Modes** - Choose your preferred workflow
- 🌍 **Cross-Platform** - Supports Windows, macOS, and Linux

### 📦 What's Included

```
cursor-machine-id/
├── 🆕 STANDALONE SCRIPTS (No Python Required!)
│   ├── change_cursor_id_windows.ps1   # 🪟 Windows PowerShell
│   ├── change_cursor_id_mac.command   # 🍎 macOS Bash
│   └── change_cursor_id_linux.sh      # 🐧 Linux Bash
│
├── PYTHON-BASED SCRIPTS (Legacy)
│   ├── quick_change.py                # 🚀 Quick auto-run script
│   ├── cursor_id_changer.py           # 🎮 Advanced interactive version
│   ├── run_mac.command                # 🍎 macOS Python launcher
│   ├── run_windows.bat                # 🪟 Windows Python launcher
│   └── run_linux.sh                   # 🐧 Linux Python launcher
│
├── requirements.txt         # 📦 Python dependencies (for Python scripts)
├── README.md                # 📖 This file
└── LICENSE                  # 📄 MIT License
```

### 🚀 Quick Start

#### **Method 1: Standalone Scripts (RECOMMENDED - No Dependencies!)**

**✨ NEW! Zero dependencies - Just double-click and run!**

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
- ✅ No Python installation required
- ✅ No dependencies to install
- ✅ Beautiful colored output
- ✅ Automatic backups
- ✅ Process detection
- ✅ Before/after comparison
- ✅ Works on fresh systems

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

### 📋 Installation

#### Option 1: Standalone Scripts (NO INSTALLATION NEEDED!)

**✨ RECOMMENDED for most users**

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
- 🎨 Beautiful colored output with `rich`
- 🛡️ Process detection with `psutil`

### 🎯 Usage Examples

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
        🔧 Cursor Machine ID Quick Changer 🔧        
======================================================================

🖥️  System: macOS 14.0
📁 Storage: /Users/user/Library/Application Support/Cursor/...
⏳ Processing...
  • Creating backup...
  ✅ Backup created
  • Generating new IDs...
  ✅ New IDs generated
  • Updating main.js...
  ✅ main.js updated

======================================================================
        ✅ Successfully Changed Cursor Machine IDs!        
======================================================================

🔄 ID Changes:
----------------------------------------------------------------------

📋 Machine ID:
  Old: 1234567890abcdef...
  New: fedcba0987654321...

[... more IDs ...]

💾 Backup created: storage.json.backup_20231211_143052
✅ main.js updated successfully

======================================================================
📝 Next Steps:
======================================================================
  1. ✅ IDs have been changed successfully
  2. 🔄 Restart Cursor editor now
  3. 🔍 Check if Cursor is working properly
  4. ⚠️  If issues persist: delete account and re-register
======================================================================

✨ Done! You can now restart Cursor.
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

### 🛠️ How It Works

The tool modifies the following device identifiers in Cursor's configuration:

- `telemetry.machineId` - Primary machine identifier (64-char hex)
- `telemetry.macMachineId` - Mac-specific identifier (64-char hex)
- `telemetry.devDeviceId` - Device UUID
- `telemetry.sqmId` - Software Quality Metrics ID (Windows)

Additionally, on macOS and Windows (v0.45.x+), it updates `main.js` to generate random UUIDs instead of using hardware-based IDs.

### 📁 Configuration File Locations

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

### ⚠️ Important Notes

1. **Close Cursor First** - Always close Cursor editor before running the script
2. **Automatic Backups** - Original files are backed up with timestamps
3. **Safe to Use** - Can restore from backups if needed
4. **Restart Required** - Restart Cursor after changing IDs
5. **Account Issues** - If problems persist, delete account and re-register

### 🔧 Troubleshooting

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

### 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

### 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### ⚠️ Disclaimer

**This tool is for educational and research purposes only.** Using this tool may violate Cursor's Terms of Service. Use at your own risk. The authors are not responsible for any issues arising from the use of this tool.

### 🙏 Credits

- Original concept from [fly8888/cursor_machine_id](https://github.com/fly8888/cursor_machine_id)
- Rewritten and modernized with colorful output and better UX
- Uses [Rich](https://github.com/Textualize/rich) for beautiful terminal output

---

## 中文文档

### ✨ 功能特性

- 🎨 **漂亮的彩色输出** - 现代化的彩色终端界面，带进度指示器
- 🖱️ **双击运行** - 所有平台都有简单的启动脚本
- 🔄 **自动生成 ID** - 生成格式正确的随机设备 ID
- 💾 **智能备份系统** - 自动备份原始配置文件
- 🛡️ **进程检测** - 如果 Cursor 正在运行会发出警告（需要 `psutil`）
- 📊 **前后对比** - 在清晰的表格中显示旧 ID 与新 ID
- 🎮 **交互式和自动模式** - 选择您喜欢的工作流程
- 🌍 **跨平台** - 支持 Windows、macOS 和 Linux

### 🚀 快速开始

#### **方法 1：独立脚本（推荐 - 无需依赖！）**

**✨ 新功能！零依赖 - 只需双击运行！**

这些原生脚本无需安装 Python，开箱即用：

1. **Windows：** 
   - 右键点击 `change_cursor_id_windows.ps1`
   - 选择"使用 PowerShell 运行"
   - （或双击，如果 PowerShell 是默认程序）

2. **macOS：** 
   - 双击 `change_cursor_id_mac.command`
   - （首次可能需要右键点击 → 打开）

3. **Linux：** 
   - 双击 `change_cursor_id_linux.sh`
   - （或在终端运行 `./change_cursor_id_linux.sh`）

**特点：**
- ✅ 无需安装 Python
- ✅ 无需安装任何依赖
- ✅ 漂亮的彩色输出
- ✅ 自动备份
- ✅ 进程检测
- ✅ 前后对比
- ✅ 在全新系统上也能运行

就这样！脚本会自动更改您的 ID 并显示彩色结果。

#### **方法 2：Python 快速更改（需要 Python）**

适合已经安装了 Python 的用户：

1. **Windows：** 双击 `run_windows.bat`
2. **macOS：** 双击 `run_mac.command`
3. **Linux：** 双击 `run_linux.sh`

或直接使用 Python 脚本：

```bash
# 直接运行 - 无需确认，自动执行
python3 quick_change.py
```

#### **方法 3：Python 交互模式（高级）**

适合想要更多控制和功能的用户：

```bash
# 带菜单的交互模式
python3 cursor_id_changer.py

# 或使用命令行选项
python3 cursor_id_changer.py --auto           # 自动模式
python3 cursor_id_changer.py --list-backups   # 列出备份
python3 cursor_id_changer.py --verbose        # 详细输出
python3 cursor_id_changer.py --dry-run        # 预览但不应用更改
```

### 📋 安装

#### 选项 1：独立脚本（无需安装！）

**✨ 推荐给大多数用户**

独立脚本零依赖：
- 无需安装 Python
- 无需安装 pip 包
- 只需下载并运行！

只需下载这些文件并运行：
- Windows：`change_cursor_id_windows.ps1`
- macOS：`change_cursor_id_mac.command`
- Linux：`change_cursor_id_linux.sh`

#### 选项 2：基于 Python 的脚本（需要 Python）

**前置要求：**
- Python 3.8 或更高版本（从 [python.org](https://www.python.org/downloads/) 下载）
- pip（通常随 Python 一起安装）

**安装依赖项（可选但推荐）：**

```bash
# 安装所有依赖项以获得最佳体验
pip install -r requirements.txt

# 或单独安装
pip install rich psutil
```

**注意：** Python 脚本在没有依赖项的情况下也能工作，但安装后您将获得：
- 🎨 使用 `rich` 的漂亮彩色输出
- 🛡️ 使用 `psutil` 的进程检测

### ⚠️ 重要注意事项

1. **先关闭 Cursor** - 运行脚本前请务必关闭 Cursor 编辑器
2. **自动备份** - 原始文件会自动备份并带有时间戳
3. **安全使用** - 如需要可以从备份恢复
4. **需要重启** - 更改 ID 后重启 Cursor
5. **账户问题** - 如果问题持续存在，删除账户并重新注册

### 🔧 故障排除

#### 独立脚本问题

**Windows PowerShell 执行策略：**
```powershell
# 如果提示"无法加载，因为在此系统上禁止运行脚本"
# 以管理员身份运行 PowerShell 并执行：
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# 然后再次尝试运行脚本
```

**macOS "无法打开" 错误：**
```bash
# 右键点击文件 → 打开（而不是双击）
# 或在终端运行：
chmod +x change_cursor_id_mac.command
./change_cursor_id_mac.command
```

**Linux 权限被拒绝：**
```bash
chmod +x change_cursor_id_linux.sh
./change_cursor_id_linux.sh
```

#### Python 脚本问题

**找不到 Python：**
```bash
# 安装 Python 3.8+
# Windows: 从 python.org 下载
# macOS: brew install python3
# Linux: sudo apt install python3
```

**权限被拒绝（Python 启动器）：**
```bash
chmod +x run_mac.command  # 或 run_linux.sh
```

#### Cursor 仍显示旧 ID
1. 完全关闭 Cursor（检查系统托盘/菜单栏）
2. 再次运行脚本
3. 重启 Cursor
4. 如仍然失败，尝试删除账户并重新注册

### 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。

### ⚠️ 免责声明

**此工具仅供学习和研究使用。** 使用此工具可能违反 Cursor 的服务条款。使用风险自负。作者不对使用此工具产生的任何问题负责。

---

<div align="center">

**Made with ❤️ for the Cursor community**

[⬆ Back to Top](#-cursor-machine-id-changer-v20)

</div>
