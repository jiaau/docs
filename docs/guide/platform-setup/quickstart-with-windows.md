# Quickstart with Windows 10

## Installation

[通过微软MediaCreationTool制作Win10系统安装U盘，安装纯净版Win10的通用教程-联想知识库 (lenovo.com.cn)](https://iknow.lenovo.com.cn/detail/177365.html) 

> [!TIP]
> 
> 后续使用系统时推荐将软件安装在非用户文件夹下的其他位置，方便后续进行数据迁移。

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

## Scoop Installation

[环境配置指南前置 – Scoop 安装配置教程 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/678611327) 

### Git Installation

```shell
scoop install git
```

> [!NOTE]
>
> 添加 Bucket 操作需要使用 Git。

### Wezterm Installation

[使用 Scoop 安装 Wezterm](https://wezfurlong.org/wezterm/install/windows.html#for-chocolatey-users)

### VSCode Installation

```shell
scoop bucket add extras
scoop install vscode
```

> [!NOTE]
> 
> extras 是 Scoop 官方维护的另一个 Bucket，包含了比 main 更多的软件包。所以这个 Bucket 里的包也是比较新的。
> 
> 你可以根据安装完成后的提示信息将 code 添加到资源管理器上下文

## Useful Tools

### winget

[使用 winget 工具安装和管理应用程序 | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/package-manager/winget/) 

### Windows Terminal (Optional)

[Windows 终端安装 | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/terminal/install) 

#### Windows Terminal but Tmux-Like

Prerequisites:

需要先安装 [JetBrainsMono](https://www.jetbrains.com/lp/mono/) 字体

然后你就可以开始配置 [Windows 终端操作 | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/terminal/customize-settings/actions)

你可以参考 [我的配置](https://github.com/whicha/config/blob/main/windows/Windows-Terminal.settings.json)

### 7-Zip

[7-Zip](https://7-zip.org/)

### VPN

[Releases · 2dust/v2rayN (github.com)](https://github.com/2dust/v2rayN/releases?ref=vps-rank)

### PowerShell

参考 [环境配置指南前置 – Windows 终端 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/678607774) 配置如下内容：

除 Windows Terminal 的内容都建议进行配置。

- 使用，升级以及配置 Powershell

- 配置终端代理

- 工具函数

- Starship 美化

- 安装 [fzf](https://github.com/junegunn/fzf) 和 [PSFzf](https://github.com/kelleyma49/PSFzf)

   - 反向搜索

   - Tab 补全

   - 目录搜索

- 其他命令行工具

   - [zoxide](https://github.com/ajeetdsouza/zoxide)

   - [bat](https://github.com/sharkdp/bat)

   - vim

[PowerShell 脚本备份](https://github.com/whicha/config/blob/main/windows/Microsoft.PowerShell_profile.ps1)

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
