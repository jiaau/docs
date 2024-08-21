# Quickstart with Windows 10

## Install Win10

[通过微软MediaCreationTool制作Win10系统安装U盘，安装纯净版Win10的通用教程-联想知识库 (lenovo.com.cn)](https://iknow.lenovo.com.cn/detail/177365.html) 

## Useful Settings

### Close Windows Defender

[Defender Control v2.1 (sordum.org)](https://www.sordum.org/9480/defender-control-v2-1/)

### 清理搜索

[更新能永久暂停？盘点两个奇特的Windows使用技巧_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1FM4y1i76d/?spm_id_from=333.999.0.0&vd_source=28c1733f23da877f7a7ff03ab05b2a54) 

Windows10:任务栏右键->搜索->搜索突出显示 关闭

```
HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\explorer
```

```
DisableSearchBoxSuggestions
```

DWORD 类型，值1

## Useful Tools

### 7-Zip

[7-Zip](https://7-zip.org/)

### VPN

[Releases · 2dust/v2rayN (github.com)](https://github.com/2dust/v2rayN/releases?ref=vps-rank)


## PowerShell Scripts

```shell
function Enable-Proxy {
    $proxy_host = '127.0.0.1'
    $proxy_port = 10809
    $proxy_url = "http://${proxy_host}:$proxy_port"

    # Set proxy-related environment variables that are widely used by applications
    $env:HTTP_PROXY = $proxy_url
    $env:HTTPS_PROXY = $proxy_url
    $env:ALL_PROXY = $proxy_url

    # Set web proxy for .NET applications
    # The second argument `$true` means bypass local addresses
    [System.Net.WebRequest]::DefaultWebProxy = New-Object System.Net.WebProxy($proxy_url, $true)
    [System.Net.Http.HttpClient]::DefaultProxy = New-Object System.Net.WebProxy($proxy_url, $true)
}
New-Alias -Name proxy -Value Enable-Proxy

function Reset-Proxy {
    # Unset proxy-related environment variables
    $env:HTTP_PROXY = ''
    $env:HTTPS_PROXY = ''
    $env:ALL_PROXY = ''

    # Unset web proxy for .NET applications
    [System.Net.WebRequest]::DefaultWebProxy = New-Object System.Net.WebProxy($null)
    [System.Net.Http.HttpClient]::DefaultProxy = New-Object System.Net.WebProxy($null)
}
New-Alias -Name unproxy -Value Reset-Proxy


<# Utility functions #>

# Unix-like `which`
function Get-CommandPath {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$name
    )

    (Get-Command $name).Path
}
New-Alias -Name which -Value Get-CommandPath

# Unix-like `touch`
function Update-File {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Path
    )

    if (Test-Path $Path) {
        (Get-ChildItem $Path).LastWriteTime = Get-Date
    }
    else {
        New-Item -Path $Path -ItemType file
    }
}
New-Alias -Name touch -Value Update-File

# Get the size of a directory. (Alias: gds)
function Get-DirectorySize {
    param (
        [string]$Path
    )

    $bytes = (Get-ChildItem $Path -Recurse -File | Measure-Object -Property Length -Sum).Sum
    if ($bytes -lt 1KB) {
        "$bytes Bytes"
    }
    elseif ($bytes -lt 1MB) {
        "$([math]::Round($bytes / 1KB, 2)) KB"
    }
    elseif ($bytes -lt 1GB) {
        "$([math]::Round($bytes / 1MB, 2)) MB"
    }
    else {
        "$([math]::Round($bytes / 1GB, 2)) GB"
    }
}
New-Alias -Name gds -Value Get-DirectorySize

# Copy the contents of a file to the clipboard. (Alias: copyfile)
function Copy-FileContentToClipboard {
    param (
        [string]$FilePath
    )

    Get-Content -Path $FilePath | Set-Clipboard
}
New-Alias -Name copyfile -Value Copy-FileContentToClipboard

# Copies the path of given directory or file to the clipboard. (Alias: copypath)
# Copy current directory if no parameter.
function Copy-Path {
    param (
        [string]$Path = (Get-Location).Path
    )

    # Resolve the path to an absolute path (but not resolving symlinks)
    $AbsolutePath = Resolve-Path -LiteralPath $Path

    # Copy the path to the clipboard
    $AbsolutePath | Set-Clipboard

    # Output the bold path, followed by a cute kaomoji
    Write-Host "`e[1m$AbsolutePath`e[0m copied to clipboard."
}
New-Alias -Name copypath -Value Copy-Path

# Open a new Windows Terminal window as admin in the current directory. (Alias: elevate)
function Open-TerminalAsAdmin {
    # Get the current directory
    $currentPath = Get-Location

    # Command to open Windows Terminal as admin in the current directory
    Start-Process wt -ArgumentList "-d", "`"$currentPath`"", "-p", "PowerShell" -Verb RunAs
}
New-Alias -Name elevate -Value Open-TerminalAsAdmin

# whicha

# Open PROFILE. (Alias: op)
function Open-Profile {
    code $PROFILE
}
New-Alias -Name op -Value Open-Profile

# Open Settings. (Alias: op)
function Open-Settings {
    code C:\Users\jiaao\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
}
New-Alias -Name os -Value Open-Settings
```

### Reference

[Windows 终端安装 | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/terminal/install) 

[使用 winget 工具安装和管理应用程序 | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/package-manager/winget/) 

[环境配置指南前置 – Windows 终端 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/678607774)

## Pacakge Manager (Scoop)

```shell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

```shell
proxy
```

```shell
irm https://get.scoop.sh -outfile 'install.ps1'
```

```shell
.\install.ps1 -ScoopDir 'C:\Users\jiaao\ProgramInstall\Tools\Scoop\install\'
```

```shell
rm .\install.ps1
```

### Reference

[环境配置指南前置 – Scoop 安装配置教程 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/678611327) 

## Tmux-Like Winodws Terminal

先安装 [JetBrainsMono](https://www.jetbrains.com/lp/mono/) 字体

然后配置 [Windows 终端操作 | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/terminal/customize-settings/actions)

```json
{
  "$help": "https://aka.ms/terminal-documentation",
  "$schema": "https://aka.ms/terminal-profiles-schema",
  /* 
    mapto: https://tmuxcheatsheet.com/
  */
  "actions": [
    {
      "command": "find",
      "keys": "ctrl+shift+f"
    },
    /* 
      Windows
      url: https://learn.microsoft.com/zh-cn/windows/terminal/customize-settings/actions#tab-management-commands
    */
    // Create window
    {
      "command": { "action": "newTab", "index": 0 },
      "keys": "ctrl+alt+c"
    },
    // Rename current window
    {
      "command": "openTabRenamer",
      "keys": "ctrl+alt+,"
    },
    // Close current window
    {
      "command": "closeTab",
      "keys": "ctrl+alt+&"
    },
    // Previous window
    {
      "command": "prevTab",
      "keys": "ctrl+alt+p"
    },
    // Next window
    {
      "command": "nextTab",
      "keys": "ctrl+alt+n"
    },
    // Switch/select window by number
    {
      "command": { "action": "switchToTab", "index": 0 },
      "keys": "ctrl+alt+0"
    },
    {
      "command": { "action": "switchToTab", "index": 1 },
      "keys": "ctrl+alt+1"
    },
    {
      "command": { "action": "switchToTab", "index": 2 },
      "keys": "ctrl+alt+2"
    },
    {
      "command": { "action": "switchToTab", "index": 3 },
      "keys": "ctrl+alt+3"
    },
    /* 
      Panes
      url: https://learn.microsoft.com/zh-cn/windows/terminal/customize-settings/actions#pane-management-commands
    */
    // Split the current pane with a horizontal line to create a horizontal layout
    {
      "command": { "action": "splitPane", "split": "horizontal" },
      "keys": "ctrl+alt+%"
    },
    // Split the current with a vertical line to create a vertical layout
    {
      "command": { "action": "splitPane", "split": "vertical" },
      "keys": "ctrl+alt+\""
    },
    // Move the current pane left
    {
      "command": { "action": "moveFocus", "direction": "left" },
      "keys": "ctrl+alt+{"
    },
    // Move the current pane right
    {
      "command": { "action": "moveFocus", "direction": "right" },
      "keys": "ctrl+alt+}"
    },
    // Switch to pane to the direction
    {
      "command": { "action": "moveFocus", "direction": "down" },
      "keys": "ctrl+alt+down"
    },
    {
      "command": { "action": "moveFocus", "direction": "left" },
      "keys": "ctrl+alt+left"
    },
    {
      "command": { "action": "moveFocus", "direction": "right" },
      "keys": "ctrl+alt+right"
    },
    {
      "command": { "action": "moveFocus", "direction": "up" },
      "keys": "ctrl+alt+up"
    },
    // Toggle pane zoom
    {
      "command": "togglePaneZoom",
      "keys": "ctrl+alt+z"
    },
    // Resize current pane
    {
      "command": { "action": "resizePane", "direction": "down" },
      "keys": "ctrl+down"
    },
    {
      "command": { "action": "resizePane", "direction": "left" },
      "keys": "ctrl+left"
    },
    {
      "command": { "action": "resizePane", "direction": "right" },
      "keys": "ctrl+right"
    },
    {
      "command": { "action": "resizePane", "direction": "up" },
      "keys": "ctrl+up"
    },
    // Close current pane
    { "command": "closePane", "keys": "ctrl+alt+x" }
    /* 
      Copy Mode
      url: https://learn.microsoft.com/zh-cn/windows/terminal/customize-settings/actions#clipboard-integration-commands
    */
  ],
  "copyFormatting": "none",
  "copyOnSelect": false,
  "defaultProfile": "{574e775e-4f2a-5b96-ac1e-a2962a402336}",
  "newTabMenu": [
    {
      "type": "remainingProfiles"
    }
  ],
  "profiles": {
    "defaults": {},
    "list": [
      {
        "colorScheme": "One Half Dark",
        "cursorHeight": 30,
        "cursorShape": "vintage",
        "experimental.retroTerminalEffect": false,
        "font": { "face": "JetBrains Mono NL", "size": 12.0 },
        "guid": "{574e775e-4f2a-5b96-ac1e-a2962a402336}",
        "hidden": false,
        "intenseTextStyle": "all",
        "name": "PowerShell",
        "opacity": 70,
        "source": "Windows.Terminal.PowershellCore",
        "useAcrylic": false
      },
      {
        "colorScheme": "One Half Dark",
        "cursorHeight": 30,
        "cursorShape": "vintage",
        "experimental.retroTerminalEffect": false,
        "font": { "face": "JetBrains Mono NL", "size": 12.0 },
        "guid": "{e5a83caa-4c73-52b3-ae6b-bc438d721ef9}",
        "hidden": false,
        "intenseTextStyle": "all",
        "name": "Ubuntu 22.04.3 LTS",
        "opacity": 70,
        "source": "CanonicalGroupLimited.Ubuntu22.04LTS_79rhkp1fndgsc",
        "useAcrylic": false
      },
      {
        "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
        "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
        "hidden": true,
        "name": "Windows PowerShell"
      },
      {
        "commandline": "%SystemRoot%\\System32\\cmd.exe",
        "guid": "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}",
        "hidden": true,
        "name": "\u547d\u4ee4\u63d0\u793a\u7b26"
      },
      {
        "guid": "{17bf3de4-5353-5709-bcf9-835bd952a95e}",
        "hidden": true,
        "name": "Ubuntu-22.04",
        "source": "Windows.Terminal.Wsl"
      },
      {
        "guid": "{b453ae62-4e3d-5e58-b989-0a998ec441b8}",
        "hidden": true,
        "name": "Azure Cloud Shell",
        "source": "Windows.Terminal.Azure"
      }
    ]
  },
  "schemes": [
    {
      "background": "#0C0C0C",
      "black": "#0C0C0C",
      "blue": "#0037DA",
      "brightBlack": "#767676",
      "brightBlue": "#3B78FF",
      "brightCyan": "#61D6D6",
      "brightGreen": "#16C60C",
      "brightPurple": "#B4009E",
      "brightRed": "#E74856",
      "brightWhite": "#F2F2F2",
      "brightYellow": "#F9F1A5",
      "cursorColor": "#FFFFFF",
      "cyan": "#3A96DD",
      "foreground": "#CCCCCC",
      "green": "#13A10E",
      "name": "Campbell",
      "purple": "#881798",
      "red": "#C50F1F",
      "selectionBackground": "#FFFFFF",
      "white": "#CCCCCC",
      "yellow": "#C19C00"
    },
    {
      "background": "#012456",
      "black": "#0C0C0C",
      "blue": "#0037DA",
      "brightBlack": "#767676",
      "brightBlue": "#3B78FF",
      "brightCyan": "#61D6D6",
      "brightGreen": "#16C60C",
      "brightPurple": "#B4009E",
      "brightRed": "#E74856",
      "brightWhite": "#F2F2F2",
      "brightYellow": "#F9F1A5",
      "cursorColor": "#FFFFFF",
      "cyan": "#3A96DD",
      "foreground": "#CCCCCC",
      "green": "#13A10E",
      "name": "Campbell Powershell",
      "purple": "#881798",
      "red": "#C50F1F",
      "selectionBackground": "#FFFFFF",
      "white": "#CCCCCC",
      "yellow": "#C19C00"
    },
    {
      "background": "#282C34",
      "black": "#282C34",
      "blue": "#61AFEF",
      "brightBlack": "#5A6374",
      "brightBlue": "#61AFEF",
      "brightCyan": "#56B6C2",
      "brightGreen": "#98C379",
      "brightPurple": "#C678DD",
      "brightRed": "#E06C75",
      "brightWhite": "#DCDFE4",
      "brightYellow": "#E5C07B",
      "cursorColor": "#FFFFFF",
      "cyan": "#56B6C2",
      "foreground": "#DCDFE4",
      "green": "#98C379",
      "name": "One Half Dark",
      "purple": "#C678DD",
      "red": "#E06C75",
      "selectionBackground": "#FFFFFF",
      "white": "#DCDFE4",
      "yellow": "#E5C07B"
    },
    {
      "background": "#FAFAFA",
      "black": "#383A42",
      "blue": "#0184BC",
      "brightBlack": "#4F525D",
      "brightBlue": "#61AFEF",
      "brightCyan": "#56B5C1",
      "brightGreen": "#98C379",
      "brightPurple": "#C577DD",
      "brightRed": "#DF6C75",
      "brightWhite": "#FFFFFF",
      "brightYellow": "#E4C07A",
      "cursorColor": "#4F525D",
      "cyan": "#0997B3",
      "foreground": "#383A42",
      "green": "#50A14F",
      "name": "One Half Light",
      "purple": "#A626A4",
      "red": "#E45649",
      "selectionBackground": "#4F525D",
      "white": "#FAFAFA",
      "yellow": "#C18301"
    },
    {
      "background": "#002B36",
      "black": "#002B36",
      "blue": "#268BD2",
      "brightBlack": "#073642",
      "brightBlue": "#839496",
      "brightCyan": "#93A1A1",
      "brightGreen": "#586E75",
      "brightPurple": "#6C71C4",
      "brightRed": "#CB4B16",
      "brightWhite": "#FDF6E3",
      "brightYellow": "#657B83",
      "cursorColor": "#FFFFFF",
      "cyan": "#2AA198",
      "foreground": "#839496",
      "green": "#859900",
      "name": "Solarized Dark",
      "purple": "#D33682",
      "red": "#DC322F",
      "selectionBackground": "#FFFFFF",
      "white": "#EEE8D5",
      "yellow": "#B58900"
    },
    {
      "background": "#FDF6E3",
      "black": "#002B36",
      "blue": "#268BD2",
      "brightBlack": "#073642",
      "brightBlue": "#839496",
      "brightCyan": "#93A1A1",
      "brightGreen": "#586E75",
      "brightPurple": "#6C71C4",
      "brightRed": "#CB4B16",
      "brightWhite": "#FDF6E3",
      "brightYellow": "#657B83",
      "cursorColor": "#002B36",
      "cyan": "#2AA198",
      "foreground": "#657B83",
      "green": "#859900",
      "name": "Solarized Light",
      "purple": "#D33682",
      "red": "#DC322F",
      "selectionBackground": "#073642",
      "white": "#EEE8D5",
      "yellow": "#B58900"
    },
    {
      "background": "#000000",
      "black": "#000000",
      "blue": "#3465A4",
      "brightBlack": "#555753",
      "brightBlue": "#729FCF",
      "brightCyan": "#34E2E2",
      "brightGreen": "#8AE234",
      "brightPurple": "#AD7FA8",
      "brightRed": "#EF2929",
      "brightWhite": "#EEEEEC",
      "brightYellow": "#FCE94F",
      "cursorColor": "#FFFFFF",
      "cyan": "#06989A",
      "foreground": "#D3D7CF",
      "green": "#4E9A06",
      "name": "Tango Dark",
      "purple": "#75507B",
      "red": "#CC0000",
      "selectionBackground": "#FFFFFF",
      "white": "#D3D7CF",
      "yellow": "#C4A000"
    },
    {
      "background": "#FFFFFF",
      "black": "#000000",
      "blue": "#3465A4",
      "brightBlack": "#555753",
      "brightBlue": "#729FCF",
      "brightCyan": "#34E2E2",
      "brightGreen": "#8AE234",
      "brightPurple": "#AD7FA8",
      "brightRed": "#EF2929",
      "brightWhite": "#EEEEEC",
      "brightYellow": "#FCE94F",
      "cursorColor": "#000000",
      "cyan": "#06989A",
      "foreground": "#555753",
      "green": "#4E9A06",
      "name": "Tango Light",
      "purple": "#75507B",
      "red": "#CC0000",
      "selectionBackground": "#555753",
      "white": "#D3D7CF",
      "yellow": "#C4A000"
    },
    {
      "background": "#300A24",
      "black": "#171421",
      "blue": "#0037DA",
      "brightBlack": "#767676",
      "brightBlue": "#08458F",
      "brightCyan": "#2C9FB3",
      "brightGreen": "#26A269",
      "brightPurple": "#A347BA",
      "brightRed": "#C01C28",
      "brightWhite": "#F2F2F2",
      "brightYellow": "#A2734C",
      "cursorColor": "#FFFFFF",
      "cyan": "#3A96DD",
      "foreground": "#FFFFFF",
      "green": "#26A269",
      "name": "Ubuntu-22.04-ColorScheme",
      "purple": "#881798",
      "red": "#C21A23",
      "selectionBackground": "#FFFFFF",
      "white": "#CCCCCC",
      "yellow": "#A2734C"
    },
    {
      "background": "#000000",
      "black": "#000000",
      "blue": "#000080",
      "brightBlack": "#808080",
      "brightBlue": "#0000FF",
      "brightCyan": "#00FFFF",
      "brightGreen": "#00FF00",
      "brightPurple": "#FF00FF",
      "brightRed": "#FF0000",
      "brightWhite": "#FFFFFF",
      "brightYellow": "#FFFF00",
      "cursorColor": "#FFFFFF",
      "cyan": "#008080",
      "foreground": "#C0C0C0",
      "green": "#008000",
      "name": "Vintage",
      "purple": "#800080",
      "red": "#800000",
      "selectionBackground": "#FFFFFF",
      "white": "#C0C0C0",
      "yellow": "#808000"
    }
  ],
  "themes": []
}
```

## Get start with WSL

### 启用功能

![](https://obsidian-gallery-cd.oss-cn-chengdu.aliyuncs.com/obsidian-first/wsl.png#errorMessage=unknown%20error&id=ngpr7&originHeight=488&originWidth=482&originalType=binary&ratio=1&rotation=0&showTitle=false&status=error&style=none) 

[安装 WSL | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/wsl/install) 

### 走 Windows 代理

```shell
export host_ip=$(cat /etc/resolv.conf |grep "nameserver" |cut -f 2 -d " ")
export http_proxy=http://$host_ip:10809
export https_proxy=http://$host_ip:10809
```

### 注意更新 wsl 版本

[WSL1升级至WSL2 - 简书 (jianshu.com)](https://www.jianshu.com/p/22dce615c8a3) 

```shell
wsl --install -d Ubuntu-22.04
```

```shell
wsl --unregister Ubuntu-22.04
```

#### 首先需要启用组件

- 使用管理员打开Powershell并运行
```shell
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
```

- 启用后会要求重启计算机

#### 其次更新WSL2内核

- 从[https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi](https://links.jianshu.com/go?to=https%3A%2F%2Fwslstorestorage.blob.core.windows.net%2Fwslblob%2Fwsl_update_x64.msi)获取WSL2 Linux内核更新包并运行
- 运行powershell
   - 查看目前的WSL版本
```shell
wsl -l -v
#输出
Name              State            Version
Ubuntu-20.04      Stopped          1
```

- 执行更新
```shell
wsl --set-version Ubuntu-18.04  2
#输出
正在进行转换，这可能需要几分钟时间...
有关与 WSL 2 的主要区别的信息，请访问 https://aka.ms/wsl2
转换完成。
```

- 完成后重新检测
```bash
wsl -l -v
#输出
Name              State            Version
Ubuntu-20.04      Stopped          2
```
