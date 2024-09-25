# Docker

## Two ways to install Docker

> [!IMPORTANT] 
> 
> [What is the difference between Docker Desktop for Linux and Docker Engine?](https://docs.docker.com/desktop/install/linux/)

### Install Docker Engine (Recommended)

跟随 [Install using the apt repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) 进行安装。

### Install Docker Desktop for Linux (Optional)

[https://docs.docker.com/desktop/install/linux-install/](https://docs.docker.com/desktop/install/linux-install/)

General system requirements:

- 你可以从 [Download QEMU](https://www.qemu.org/download/#linux) 安装 QEMU

然后使用 

```shell
qemu-system-x86_64 --version
```

查看其版本。

- 设置 [KVM virtualization support](https://docs.docker.com/desktop/install/linux-install/#kvm-virtualization-support)

接下来就可以进入安装步骤：

[https://docs.docker.com/desktop/install/ubuntu/#install-docker-desktop](https://docs.docker.com/desktop/install/ubuntu/#install-docker-desktop)

1. Set up Docker's package repository. See **step one** of [Install using theaptrepository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

:::details 可能遇到的问题与解决方案：

- [Docker安装遇到问题：curl: (7) Failed to connect to download.docker.com port 443: 拒绝连接-CSDN博客](https://blog.csdn.net/Fengdf666/article/details/140221138)

:::

2. Download [latest DEB package](https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64&_gl=1*1bdcvx9*_gcl_aw*R0NMLjE3MjI2NTQzODYuRUFJYUlRb2JDaE1JM2NLTDB1dlhod01WM2x3UEFoMTlhQUNLRUFBWUFTQUFFZ0kxQWZEX0J3RQ..*_gcl_au*MTA5NDI0NzA4NC4xNzIyNjA0OTYx*_ga*OTY4MDY2MzUzLjE3MjI2MDQ5NjE.*_ga_XJWPQMJYHQ*MTcyMjY2Njc4OC40LjEuMTcyMjY2ODk2MS41OS4wLjA.).

3. Install the package with apt as follows:

```shell
sudo apt-get update
sudo apt-get install ./docker-desktop-<arch>.deb
```

## Proxy Config

参考： [docker设置全局代理（win/linux）](https://zhuanlan.zhihu.com/p/413353281?utm_id=0)

**Prerequisites**: 

- 参照 [proxy](../tools/proxy.md) 设置代理。

### Docker Desktop for Linux

代理软件打开全局模式

![clash-proxy.png](./docker/clash-proxy.png)

在 Docker Desktop 中设置代理软件端口

![docker-proxy.png](./docker/docker-proxy.png)

> [!IMPORTANT]
> 
> 注意两个地址都是 `http`

### Docker Engine

```sh
sudo vim /etc/docker/daemon.json
```

```json
{
  "proxies": {
    "http-proxy": "http://127.0.0.1:7891",
    "https-proxy": "http://127.0.0.1:7891"
  }
}
```

```sh
sudo systemctl restart docker.service
```

## Sign in to Docker Desktop for Linux

> [!NOTE]
> 
> 中国大陆用户需要进行代理设置后才能进行登陆操作。

相关设置参考： [Signing in with Docker Desktop for Linux](https://docs.docker.com/desktop/get-started/#signing-in-with-docker-desktop-for-linux)

## Docker Container

### docker container commit

Create a new image from a container's changes.

[docker container commit](https://docs.docker.com/reference/cli/docker/container/commit/)

## Dockerfile

### ARG

[ARG](https://docs.docker.com/reference/dockerfile/#arg)

> using ARG, which is not persisted in the final image

Use Cases:

```Dockerfile
ARG DEBIAN_FRONTEND=noninteractive
```

### ENV

[ENV](https://docs.docker.com/reference/dockerfile/#env)

> The environment variables set using ENV will persist when a container is run from the resulting image. 

Use Cases:

- [How do I integrate pyenv, poetry, and docker?](https://stackoverflow.com/questions/65768775/how-do-i-integrate-pyenv-poetry-and-docker)

### Creating a non-root user

[Creating a non-root user](https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user#_creating-a-nonroot-user)

> [!NOTE] 
> 
> there are some quirks with local filesystem (bind) mounts that you should know about. Specifically:
> 
> - **Docker CE/EE on Linux**: Inside the container, any mounted files/folders will have the exact same permissions as outside the container - including the owner user ID (UID) and group ID (GID). Because of this, your container user will either need to have the same UID or be in a group with the same GID. The actual name of the user / group does not matter. The first user on a machine typically gets a UID of 1000, so most containers use this as the ID of the user to try to avoid this problem.

更新容器用户的 UID/GID 以匹配本地用户，从而避免在此环境中存在的绑定挂载权限问题。

下面介绍几种绑定挂载的情形：

::: details **TL;DR**
容器内和宿主机用户权限一致（UID与GID）相同，且权限高于或等于挂载文件夹权限才可进行正常读写操作。
:::

#### root-user && 未手动创建挂载文件夹：

```sh
$ docker run --name test -it --rm -v ./mount:/mount -w /mount ubunt
```

**宿主机：**

``` sh
$ stat mount
  File: mount
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 10303h/66307d   Inode: 4200464     Links: 2
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2024-09-21 16:30:52.385977343 +0800
Modify: 2024-09-21 16:30:52.385977343 +0800
Change: 2024-09-21 16:30:52.385977343 +0800
 Birth: 2024-09-21 16:30:52.385977343 +0800

$ cd mount

$ touch tmp.txt
touch: cannot touch 'tmp.txt': Permission denied
```

宿主机一侧无法正常写入。

**容器：**


```sh
root@ac28467c4207:/mount# stat ../mount
  File: ../mount
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 259,3   Inode: 4200464     Links: 2
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2024-09-21 09:01:28.964555406 +0000
Modify: 2024-09-21 09:01:04.357228378 +0000
Change: 2024-09-21 09:01:04.357228378 +0000
 Birth: 2024-09-21 09:01:04.357228378 +0000

root@ac28467c4207:/mount# touch tmp.txt

root@ac28467c4207:/mount# ls
tmp.txt
```

:::info 结论
这种情况下主机侧无法对绑定文件夹进行写操作。
:::

#### root-user && 手动创建挂载文件夹：

```sh
$ mkdir mount

$ docker run --name test -it --rm -v ./mount:/mount -w /mount ubuntu

```

**宿主机：**

```sh
$ stat mount
  File: mount
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 10303h/66307d   Inode: 4200464     Links: 2
Access: (0775/drwxrwxr-x)  Uid: ( 1000/   <host_user>)   Gid: ( 1000/   <host_user>)
Access: 2024-09-21 17:12:50.286737647 +0800
Modify: 2024-09-21 17:11:55.730996463 +0800
Change: 2024-09-21 17:11:55.730996463 +0800
 Birth: 2024-09-21 17:11:55.730996463 +0800

$ cd mount
$ touch tmp.txt
$ vim tmp.txt
$ stat tmp.txt
  File: tmp.txt
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 10303h/66307d   Inode: 4214763     Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/   <host_user>)   Gid: ( 1000/   <host_user>)
Access: 2024-09-21 17:15:41.569068352 +0800
Modify: 2024-09-21 17:15:41.569068352 +0800
Change: 2024-09-21 17:15:41.574068420 +0800
 Birth: 2024-09-21 17:15:41.569068352 +0800
```

**容器：**


```sh
root@ace8ee44285f:/mount# stat ../mount
  File: ../mount
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 259,3   Inode: 4200464     Links: 2
Access: (0775/drwxrwxr-x)  Uid: ( 1000/  ubuntu)   Gid: ( 1000/  ubuntu)
Access: 2024-09-21 08:35:05.326585897 +0000
Modify: 2024-09-21 08:35:05.326585897 +0000
Change: 2024-09-21 08:35:05.326585897 +0000
 Birth: 2024-09-21 08:35:05.326585897 +0000

root@b9bb71e6d803:/mount# stat tmp.txt
  File: tmp.txt
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 259,3   Inode: 4214763     Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/  ubuntu)   Gid: ( 1000/  ubuntu)
Access: 2024-09-21 09:15:41.569068352 +0000
Modify: 2024-09-21 09:15:41.569068352 +0000
Change: 2024-09-21 09:15:41.574068420 +0000
 Birth: 2024-09-21 09:15:41.569068352 +0000

root@ace8ee44285f:/mount# touch tmp1.txt

root@ace8ee44285f:/mount# stat tmp1.txt
  File: tmp1.txt
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 259,3   Inode: 4200614     Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2024-09-21 08:35:55.151290352 +0000
Modify: 2024-09-21 08:35:55.151290352 +0000
Change: 2024-09-21 08:35:55.151290352 +0000
 Birth: 2024-09-21 08:35:55.151290352 +0000
```

**宿主机：**

```sh
$ vim tmp1.txt
```

`:i` 进入插入模式

```txt
-- INSERT -- W10: Warning: Changing a readonly file
```

在这种情况下 host 一侧无法对文件正常写入，交互出现问题。

`:wq`

```txt
E45: 'readonly' option is set (add ! to override)
```

`:wq!`

```sh
$ mount stat tmp1.txt
  File: tmp1.txt
  Size: 5               Blocks: 8          IO Block: 4096   regular file
Device: 10303h/66307d   Inode: 4200625     Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/   <host_user>)   Gid: ( 1000/   <host_user>)
Access: 2024-09-21 16:51:09.525037052 +0800
Modify: 2024-09-21 16:51:09.525037052 +0800
Change: 2024-09-21 16:51:09.528037094 +0800
 Birth: 2024-09-21 16:51:09.525037052 +0800
```

**容器：**

```sh
root@ace8ee44285f:/mount# stat tmp1.txt
  File: tmp1.txt
  Size: 5               Blocks: 8          IO Block: 4096   regular file
Device: 259,3   Inode: 4200625     Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/  ubuntu)   Gid: ( 1000/  ubuntu)
Access: 2024-09-21 08:51:09.525037052 +0000
Modify: 2024-09-21 08:51:09.525037052 +0000
Change: 2024-09-21 08:51:09.528037094 +0000
 Birth: 2024-09-21 08:51:09.525037052 +0000
```

可以看到文件权限发生变化。

:::info 结论
这种情况下主机侧无法对容器内 root 用户创建的文件进行写操作。
:::

#### non-root-user && 未手动创建挂载文件夹

```sh
$ docker run --name test -it --rm -v ./mount:/mount -w /mount image-with-non-root-user
```

**宿主机：**

```sh
$ stat mount
  File: mount
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 10303h/66307d   Inode: 4200464     Links: 2
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2024-09-21 17:25:06.632782035 +0800
Modify: 2024-09-21 17:25:01.207707861 +0800
Change: 2024-09-21 17:25:01.207707861 +0800
 Birth: 2024-09-21 17:25:01.207707861 +0800

$ cd mount

$ touch tmp.txt
touch: cannot touch 'tmp.txt': Permission denied
```

**容器：**

```sh
$ stat ../mount
  File: ../mount
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 10303h/66307d   Inode: 4200464     Links: 2
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2024-09-21 09:25:06.632782035 +0000
Modify: 2024-09-21 09:25:01.207707861 +0000
Change: 2024-09-21 09:25:01.207707861 +0000
 Birth: 2024-09-21 09:25:01.207707861 +0000

$ touch tmp.txt
touch: cannot touch 'tmp.txt': Permission denied
```

:::info 结论
宿主机和容器都无法对挂载文件夹进行正常写操作。
:::

#### non-root-user && 手动创建挂载文件夹

```sh
$ mkdir mount

$ docker run --name test -it --rm -v ./mount:/mount -w /mount image-with-non-root-user
```

**宿主机：**

```sh
$ stat mount
  File: mount
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 10303h/66307d   Inode: 4200464     Links: 2
Access: (0775/drwxrwxr-x)  Uid: ( 1000/   <host_user>)   Gid: ( 1000/   <host_user>)
Access: 2024-09-21 17:34:03.452126222 +0800
Modify: 2024-09-21 17:33:51.163958037 +0800
Change: 2024-09-21 17:33:51.163958037 +0800
 Birth: 2024-09-21 17:33:51.163958037 +0800
```

**容器：**

```sh
$ stat ../mount
  File: ../mount
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 10303h/66307d   Inode: 4200464     Links: 2
Access: (0775/drwxrwxr-x)  Uid: ( 1000/containeruser)   Gid: ( 1000/containeruser)
Access: 2024-09-21 09:34:03.452126222 +0000
Modify: 2024-09-21 09:33:51.163958037 +0000
Change: 2024-09-21 09:33:51.163958037 +0000
 Birth: 2024-09-21 09:33:51.163958037 +0000
```

:::info 结论
宿主机和容器都均可对挂载文件夹进行正常写操作。
:::

#### Related Links

[Linux chmod命令](https://www.runoob.com/linux/linux-comm-chmod.html)

[Bind mounts](https://docs.docker.com/engine/storage/bind-mounts/)

[Mount volume (-v)](https://docs.docker.com/reference/cli/docker/container/run/#volume)


### How do I Docker COPY as non root?

[How do I Docker COPY as non root?](https://stackoverflow.com/a/44766666/26612416)

```Dockerfile
COPY --chown=<user>:<group> <hostPath> <containerPath>
```

`user` 和 `group` 可为 `uid` 和 `gid`，见：

```Dockerfile
COPY --chown=$USER_UID:$USER_GID . .
```

## Docker image

### docker保存、导入、导出和加载tar及其tar.gz

[docker保存、导入、导出和加载tar及其tar.gz](https://blog.csdn.net/qq_31066285/article/details/126267993)