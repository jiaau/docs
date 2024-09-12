# Docker

## Two ways to install Docker

### Install Docker Engine (Recommended)

跟随 [Install using the apt repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) 进行安装。

### Install Docker Desktop (Optional)

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

代理软件打开全局模式

![clash-proxy.png](./docker/clash-proxy.png)

在 Docker Desktop 中设置代理软件端口

![docker-proxy.png](./docker/docker-proxy.png)

> [!IMPORTANT]
> 
> 注意两个地址都是 `http`

## Sign in to Docker Desktop (Optional)

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
without env, I should source .zshrc/.bashrc/.profile etc in every layer including container start

Use Cases:

- [How do I integrate pyenv, poetry, and docker?](https://stackoverflow.com/questions/65768775/how-do-i-integrate-pyenv-poetry-and-docker)
