# Quickstart with Ubuntu 22.04 Desktop

## Operating System Installation

[Windows11 + Linux (Ubuntu22.04) 双系统最简安装详细避坑版_win11安装linux双系统-CSDN博客](https://blog.csdn.net/2401_84064328/article/details/137232169)

### 制作 Ubuntu 安装 U盘

下载官方镜像： [Ubuntu 22.04.4 LTS (Jammy Jellyfish)](https://releases.ubuntu.com/jammy/)

下载 [Ventoy](https://gitee.com/longpanda/Ventoy/releases/) 

下载后打开，在 `设备` 选择 U盘，`配置选项` 下的 `分区类型` 选择 `GPT`。

点击 `安装` 即可。

最后将下载好的官方镜像拖入 U盘，启动盘便制作完成了。

### 设置 BIOS

主板插上 U盘，接上键盘，启动电源，按 `F11` 进入到 BIOS 界面。

将 `BIOS Mode` 由 `UEFI` 更改为 `CSM`。（默认是 `UEFI`）。

设置 U盘优先级。

正确保存设置后，退出将进入系统引导界面。

### 系统安装

> [!IMPORTANT]
> 
> 如果硬盘没有正确安装，在硬盘分区时会看不到和硬盘大小接近的区域的，所以需要正确安装硬盘。

分区设置：

- 从硬盘新建一个类型为 `efi` 的分区，用于存放系统引导文件，然后在当前页面最后一栏选择其作为安装引导器的设备。

笔者给的大小是 512 MB，通过 

```sh
df -h
```
查看后，信息如下：

```txt
Filesystem      Size  Used Avail Use% Mounted on
/dev/nvme0n1p1  487M  6.1M  480M   2% /boot/efi
```

所以说，应该是不需要这么大的。

- 继续从空闲磁盘区域新建类型为 `ext4` 的分区用于挂载文件系统。

笔者将除去 `efi` 分区的剩余空间全部用于挂载 `/` 文件系统了。

> [!NOTE]
> 
> 你可以新建多个分区，然后将文件系统的不同部分挂载到对应的分区之上，便于后续数据迁移和系统重装。
> 
> 分区类型还有其他类型，如 `swap` 类型，作为内存交换分区，如有需要可自行探索。

## Base Configuration

### Base Configuration 1

[wezterm](https://wezfurlong.org/wezterm/install/linux.html#using-the-apt-repo) 终端安装

#### Commandline Tools

[环境配置指南 – Ubuntu 20.04 杂项（服务器）](https://zhuanlan.zhihu.com/p/700219388)

- 使用 [pyenv](https://github.com/pyenv/pyenv) 安装和管理 python 版本

- 常用命令行工具安装：

  - [bat](https://github.com/sharkdp/bat)

  - [zoxide](https://github.com/ajeetdsouza/zoxide)

  - [fd](https://link.zhihu.com/?target=https%3A//github.com/sharkdp/fd)

  - [rigrep](https://github.com/BurntSushi/ripgrep)

#### Proxy

将下面的脚本添加到 `.zshrc` 或其他 shell 配置文件中。

```shell
# >>> proxy >>>
proxy() {
  proxy_host='127.0.0.1'
  proxy_port=7890
  http_proxy_url="http://$proxy_host:$proxy_port"
  socks5_proxy_url="socks5://$proxy_host:$proxy_port"

  export http_proxy=$http_proxy_url
  export HTTP_PROXY=$http_proxy_url
  export https_proxy=$http_proxy_url
  export HTTPS_PROXY=$http_proxy_url
  export all_proxy=$socks5_proxy_url
  export ALL_PROXY=$socks5_proxy_url
}

unproxy() {
  unset http_proxy
  unset HTTP_PROXY
  unset https_proxy
  unset HTTPS_PROXY
  unset all_proxy
  unset ALL_PROXY
}
# <<< proxy <<<
```

当你 `curl` 不下来时，可以尝试 `proxy` 

### Base Configuration 2

[环境配置指南 – Ubuntu 22.04 杂项](https://zhuanlan.zhihu.com/p/686485113)

#### 中文输入法配置

  - 你可能需要的链接：[解决Linux使用fcitx5输入法无法输入问题](https://www.bilibili.com/read/cv21085970/)

#### GNOME 插件安装

  - [vitals](https://extensions.gnome.org/extension/1460/vitals/)

  - [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)

  - [Pano](https://extensions.gnome.org/extension/5278/pano/)

  - [Caffeine](https://extensions.gnome.org/extension/517/caffeine/)

> [!NOTE]
> 
> Pano 需要按照其 [Github Repository](https://github.com/oae/gnome-shell-pano?tab=readme-ov-file#installation) 进行安装

### Appendices

[我的镜像构建仓库](https://github.com/whicha/images) 中记录了上述部分软件的安装指令，可以通过 [Dockerfile](https://github.com/whicha/images/blob/base/Dockerfile) 进行查看。

## Remote Configuration

以 [【保姆级教程】个人深度学习工作站配置指南](https://zhuanlan.zhihu.com/p/336429888) 为大纲，进行如下配置：

> [!CAUTION]
> 
> 不要跟随这个教程替换国内镜像软件源，后续可能存在问题。

### 设置 root 账户和密码

### 为自己的账户设置 sudo 免密使用

### 配置 SSH & 远程桌面

> [!NOTE]
> 
> 参照 [Xrdp Slow ? #2136](https://github.com/neutrinolabs/xrdp/discussions/2136) 设置 Windows Client 端的连接，提升使用体验。

### 安装 frp 进行内网穿透

下面的教程基于：

- 具有公网 ip 的 Ubuntu 服务器

- 安装有 Ubuntu 的主机

- 个人 Windows 电脑

到 [这里](https://github.com/fatedier/frp/releases) 根据你的系统选择合适的版本下载 frp。

> [!NOTE]
> 
> 配置会基于软件所在位置进行，注意配置示例中的软件位置是否和你的一致。

#### 云服务器端

##### 下载

解压：

```shell
tar -xzvf <frp_zip_you_download>
```

```sh
sudo mkdir -p /usr/local/bin/frp
sudo cp <frp_you_download>/. /usr/local/bin/frp
```

##### 配置

编辑配置文件：

```shell
vim frps.ini
```
输入以下内容：

```txt
# frps.ini
bindPort = 7000

webServer.addr = "0.0.0.0"
webServer.port = 7500

webServer.user = "user_who_can_access_webui"
webServer.password = "password"

auth.method = "token"
auth.token = "client can communicate with server with this token."
```

`bindPort` 为 fprc 连接 frps 的端口。

webui 设置参考：[Web 界面](https://gofrp.org/zh-cn/docs/features/common/ui/)

身份验证参考：[身份认证](https://gofrp.org/zh-cn/docs/features/common/authentication/)


##### 自动化任务

新建任务：

```shell
sudo vim /etc/systemd/system/frps.service
```

配置：

```txt
[Fusion]
Description=Frp Server Daemon
After=syslog.target network.target
Wants=network.target
​
[Service]
Type=simple
ExecStart=/usr/local/bin/frp/frps -c /usr/local/bin/frp/frps.ini # 修改为你的frp实际安装目录
ExecStop=/usr/bin/killall frps
#启动失败1分钟后再次启动
RestartSec=1min
KillMode=control-group
#重启控制：总是重启
Restart=always
​
[Install]
WantedBy=multi-user.target
```

启动服务：

```shell
sudo systemctl enable frps.service
sudo systemctl start frps.service
```

查看任务状态：

```shell
sudo systemctl status frps.service
```

> [!NOTE]
> 
> 上述脚本假设你的系统安装了 `killall` 程序，如果没有可以使用如下命令进行安装：
>
> ```sh
> sudo apt-get install  psmisc
> ```

#### 主机端

##### 下载

解压：

```shell
tar -xzvf <frp_zip_you_download>
```

```sh
sudo mkdir -p /usr/local/bin/frp
sudo cp <frp_you_download>/. /usr/local/bin/frp
```

##### 配置

编辑配置文件：

```shell
vim frpc.ini
```
输入以下内容：

```txt
serverAddr = "ip_of_web_server"
serverPort = 7000

auth.method = "token"
auth.token = "client can communicate with server with this token."

[[proxies]]
name = "ssh"
type = "tcp"
localPort = 22
remotePort = 20022

[[proxies]]
name = "p2p_ssh"
type = "xtcp"
secretKey = "abcdefg"
localPort = 22
localIP = "127.0.0.1"

[[proxies]]
name = "xrdp"
type = "tcp"
localPort = 3389
remotePort = 23389

[[proxies]]
name = "p2p_xrdp"
type = "xtcp"
secretKey = "abcdefg"
localPort = 3389
localIP = "127.0.0.1"
```

以上配置文件对 ssh 和 xrdp 提供了以云服务器为媒介和 p2p 直接访问两种方式。 p2p 配置可参考：[](https://gofrp.org/zh-cn/docs/examples/xtcp/)

##### 自动化任务

新建任务：

```shell
sudo vim /etc/systemd/system/frpc.service
```

配置：

```txt
[Fusion]
Description=Frp Server Daemon
After=syslog.target network.target
Wants=network.target
​
[Service]
Type=simple
ExecStart=/usr/local/bin/frp/frpc -c /usr/local/bin/frp/frpc.ini # 修改为你的frp实际安装目录
ExecStop=/usr/bin/killall frpc
#启动失败1分钟后再次启动
RestartSec=1min
KillMode=control-group
#重启控制：总是重启
Restart=always
​
[Install]
WantedBy=multi-user.target
```

启动服务：

```shell
sudo systemctl enable frpc.service
sudo systemctl start frpc.service
```

查看任务状态：

```shell
sudo systemctl status frps.service
```

#### PC 端

使用你下载的解压工具进行解压。

##### 配置

新建 `frpc.ini` ，输入以下内容。

```txt
serverAddr = ""
serverPort = 7000

auth.method = "token"
auth.token = "client can communicate with server with this token."

[[visitors]]
name = "p2p_ssh_visitor"
type = "xtcp"
serverName = "p2p_ssh"
secretKey = "abcdefg"
bindAddr = "127.0.0.1"
bindPort = 20022
keepTunnelOpen = true
protocol = "kcp"

[[visitors]]
name = "p2p_xrdp_visitor"
type = "xtcp"
serverName = "p2p_xrdp"
secretKey = "abcdefg"
bindAddr = "127.0.0.1"
bindPort = 23389
keepTunnelOpen = true
protocol = "kcp"
```

PC 通过 `serverName` 和 `serverKey` 来识别主机对应服务，然后通过访问本地端口使用主机服务。

以 ssh 服务为例，你可以在 `~/.ssh/config` 下添加如下内容：

```txt
Host my_host
  HostName 127.0.0.1
  Port 20022
  User user_name
```

然后使用：

```shell
ssh my_host
```

访问主机。

> [!NOTE]
> 
> p2p 原理： 初次连接时依靠云服务器知晓对方在网络中的位置后，后续连接便可直接通信。
> 
> 虽然 p2p 方式具有更低的延迟，且不受限于云服务器的带宽限制，但是这种方式不一定会成功，取决于主机和 PC 所处的网络环境。

##### 自动化任务

按 Windows 键，键入 `任务计划程序`。

打开后，右键左侧边栏的 `任务计划程序库`，选择创建任务，对每个选项卡依次按需配置。

- 在常规一栏设置名称即可。

- 触发器一栏设置登录时（当任何用户登录时），防止电脑名更改需要手动启动，启动时。

- 在操作一栏，点击 `新建`，操作为 `启动程序`，点击 `浏览`，找到 `frpc.exe` ，添加参数 `-c C:\Softwares\Tools\frp\frpc.ini`。

- 建议在条件一栏只勾选 `网络`。


## Deep Learning Configuration

以 [【保姆级教程】个人深度学习工作站配置指南](https://zhuanlan.zhihu.com/p/336429888) 为大纲，进行如下配置：

以下配置优先参照官方文档进行安装。

### NVIDIA GPU driver

参 zhihuijun 文档进行可视化安装。

安装完成后输入：

```shell
nvidia-smi
```

你就能看到驱动最高能支持的 CUDA 版本，接下来，你所安装的 CUDA 版本**不能**高于该驱动版本。

### CUDA

到 [CUDA Toolkit Archive](https://developer.nvidia.com/cuda-toolkit-archive) 选择你要安装的版本。

后续参照 zhihuijun 文档设置环境变量信息。

### CuDNN

参照 [cuDNN 9.4.0 Downloads](https://developer.nvidia.com/cudnn-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_local) 进行安装。

### Conda

使用 [Quick command line install](https://docs.anaconda.com/miniconda/#quick-command-line-install) 安装 Miniconda。

建议安装在 `/home/<user_name>/Softwares/miniconda3` 文件夹。

基础使用： [Cheatsheet](https://docs.conda.io/projects/conda/en/latest/user-guide/cheatsheet.html#cheatsheet)

### NVIDIA Container Toolkit

首先需要安装 Docker，可参照 [docker](../basic-skills/docker.md) 进行。

参照 [Installing the NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) 进行安装配置。

测试：[Running a Sample Workload with Docker](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/sample-workload.html#running-a-sample-workload-with-docker)

从 [NVIDIA/nvidia-container-toolkit](https://github.com/NVIDIA/nvidia-container-toolkit) 提供的架构图可以理解如下内容：

> Make sure you have installed the NVIDIA driver for your Linux Distribution Note that you do not need to install the CUDA Toolkit on the host system, but the NVIDIA driver needs to be installed

从而你便能基于该工具在不同的容器中使用不同版本的 CUDA，下面以 pytorch 的使用来举例。

在 [Installing previous versions of PyTorch](https://pytorch.org/get-started/previous-versions/#installing-previous-versions-of-pytorch) 选择项目需要的 pytorch 版本，以及对应的 CUDA 版本。

在 [CUDA and cuDNN images from gitlab.com/nvidia/cuda](https://hub.docker.com/r/nvidia/cuda) 找到对应 CUDA 版本的镜像拉取。

镜像区别可在页面的 `Overview of Images` 处找到。

> Three flavors of images are provided:
> 
> - base: Includes the CUDA runtime (cudart)
> 
> - runtime: Builds on the base and includes the CUDA math libraries⁠, and NCCL⁠. A runtime image that also includes cuDNN⁠ is available.
> 
> - devel: Builds on the runtime and includes headers, development tools for building CUDA images. These images are particularly useful for multi-stage builds.

拉取后可进行如下测试：

```shell
sudo docker run -it --name test_nvidia_docker --gpus all nvidia/cuda:11.1-base 
```

:::details 可能遇到的问题与解决方案：

- [Failed to initialize NVML](https://stackoverflow.com/a/78137688)

:::

进入镜像后可使用如下命令，检查 CUDA 版本：

```shell
nvcc -V
```
你还可以通过：

```sh
cat /etc/os-release
```

查看镜像的 Ubuntu 版本。

## Tips & Tricks

### What is the correct way to completely remove an application? 

[What is the correct way to completely remove an application?](https://askubuntu.com/questions/187888/what-is-the-correct-way-to-completely-remove-an-application)
