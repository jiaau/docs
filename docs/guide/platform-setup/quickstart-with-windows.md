# Quickstart with Windows 10

## Installation

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


## PowerShell

### Installation

[Windows 终端安装 | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/terminal/install) 

[使用 winget 工具安装和管理应用程序 | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/package-manager/winget/) 

### Resources

[环境配置指南前置 – Windows 终端 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/678607774)

[PowerShell 脚本备份](https://github.com/whicha/config/blob/main/windows/Microsoft.PowerShell_profile.ps1)

### Windows Terminal but Tmux-Like

Prerequisites:

需要先安装 [JetBrainsMono](https://www.jetbrains.com/lp/mono/) 字体

然后你就可以开始配置 [Windows 终端操作 | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/terminal/customize-settings/actions)

你可以参考 [我的配置](https://github.com/whicha/config/blob/main/windows/Windows-Terminal.settings.json)

## Pacakge Manager (Scoop)

### Resources

[环境配置指南前置 – Scoop 安装配置教程 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/678611327) 

## WSL

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
