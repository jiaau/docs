# Synchronizing files between machines using Syncthing

## Why Syncthing

为什么选择 [Syncthing](https://github.com/syncthing/syncthing) ？

- 有备份文件/实时同步文件的需求
- 开源可控

## Getting Started

Prerequisites:

- 主机间能够进行通信（在同一局域网内/至少有 一台主机具有公网 ip）。

本文的场景为一台阿里云服务器 + 一台本地主机，系统均为 Debian 系。系统可能和你的存在差异，你可以在 [这里](https://docs.syncthing.net/intro/getting-started.html) 参考官方的教程。

### Installation

你可以在 [Community Contributions](https://docs.syncthing.net/users/contrib.html#contributions) 根据你的平台选择合适的安装方式。

下面提供了两种安装方式：
- 使用 Docker 安装
- 直接安装在本机

#### Run Syncthing in Docker

根据 [Example Usage](https://github.com/syncthing/syncthing/blob/main/README-Docker.md#example-usage) 文档进行配置。

> Note that Docker's default network mode prevents local IP addresses from being discovered, as Syncthing is only able to see the internal IP of the container on the 172.17.0.0/16 subnet. This will result in poor transfer rates if local device addresses are not manually configured.

> [!NOTE]
> 笔者使用官方给出在 [host network mode](https://docs.docker.com/network/host/) 下的 [配置](https://github.com/syncthing/syncthing/blob/main/README-Docker.md#discovery) 时，无法访问 admin GUI 网址，从而无法使用。

建议使用 `docker-compose.yml` 文件，方便修改配置，复制对应配置内容，然后输入以下命令启动容器。

```shell
docker compse up
```
> [!NOTE]
> 这种安装方式使用 [Mount volume](https://docs.docker.com/reference/cli/docker/container/run/#volume) mounts host directory into container directory，普通用户只能进行读，写操作需要使用 `sudo` 命令。

#### Debian/Ubuntu Packages

根据 [这里](https://apt.syncthing.net/) 的指令进行安装。

使用以下命令进行启动：

```shell
syncthing
```

### Config

> [!TIP]
> 主机的 IP 会被编码到 ID，所以添加远程设备后，便能知道对方地址。
> 
> 可以把共享文件夹想象成一个点，当主机设置为 `发送和接收` 时与该点的联系是双向的，`仅发送` 时箭头指向该点，`仅接收` 时则从该点指向主机。需要访问该文件夹的主机之间由此建立联系。

#### 实时同步文件夹

1. 添加远程设备：

本地主机启动 `Syncthing` ，复制其 ID。

在 VSCode 中下载 Remote SSH 插件连接到云服务器，以使用 VSCode 的端口转发功能，从而能在本地配置同步相关的设置，不用开放服务器的端口。

启动云服务器上的 `Syncthing` ，点击添加远程设备，粘贴本地主机的 ID 。

复制云服务器 ID ，然后在本地主机上添加远程设备。

2. 本地添加同步文件夹：

在常规选项卡设置同步文件夹在本机的路径。

在共享选项卡选择需要同步该文件夹的远程设备。

在高级选项卡设置文件夹类型为 `发送和接收` ，可在`完整扫描间隔`处设置同步间隔。

3. 云服务器重复步骤 2 ，**注意**：需保证文件夹 ID 一致。

4. 配置云服务器安全组

#### 备份本地主机数据到云服务器

步骤与实时同步文件夹基本相同，只是文件夹类型有差异：

- 本地文件夹类型设置为`仅发送`
- 云服务器文件夹类型设置为`仅接收`

TODO: 
- 补充图片
