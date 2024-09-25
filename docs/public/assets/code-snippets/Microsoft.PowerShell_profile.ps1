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