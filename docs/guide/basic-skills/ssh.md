# SSH

## Basics

[VSCode配置 SSH连接远程服务器+免密连接教程](https://zhuanlan.zhihu.com/p/667236864)

通常你使用 ssh 连接到一台服务器时需要输入如下命令：

```sh
ssh -p 22 root@127.0.0.1
# ssh -p <port> <login_user>@<ip>
```

如果连接成功，会提示你输入 password of login_user。

每次输入这么长串命令会有些麻烦，实际上你可以简化连接命令，你需要：

```sh
vim ~/.ssh/config
```

输入以下内容：

```txt
Host server
  HostName 127.0.0.1
  Port 22
  User root
```

从此以后你便只需要使用：

```sh
ssh server
```

便可以连接到对应服务器了。

> [!NOTE]
> 
> 当你使用 VSCode 并下载了 Remote-SSH 插件时，点击左侧边栏的 Remote Explorer 图标，你就能在 SSH 下看到名为 server 的主机了。

每次都需要输入密码，也会有些繁琐，尤其是当你使用 VSCode 远程连接服务器进行开发时，每次切换文件夹都需要重复输入密码。接下来我们将解决这个问题：

在本地主机下输入以下命令：

```sh
ssh-keygen
```

然后一路回车，该命令会在 `~/.ssh` 目录下生成 `id_rsa` 和 `id_rsa.pub` 两个文件，前者是你的私钥，后者则是公钥。

> [!NOTE]
> 
> `ssh-keygen` 命令有其他可选参数，如使用 -f 指定生成位置和文件名，如 `ssh-keygen <path>\id_rsa_custom`。
> 
> 再配合上 `~/.ssh/config` 的 `IdentityFile` 属性，能满足你针对不同服务器使用不同的公钥私钥对的需求。

复制公钥（id_rsa.pub）的内容，在需要免密连接的服务器的 `~/.ssh` 文件夹下创建 `authorized_keys` 文件（如果没有的话），然后在其中追加刚才复制的公钥内容。

> [!IMPORTANT]
> 
> 如果你使用 -f 修改了默认文件位置以及名称，你需要对 `~/.ssh/config` 的文件内容进行如下修改：

```txt
Host server
  HostName 127.0.0.1
  Port 22
  User root
  IdentityFile <path>\id_rsa_custom
```

再次使用

```sh
ssh server
```

连接主机，将不再要求输入密码。

> [!NOTE]
> 
> 如果你想知道为什么要进行如上操作，[什么是SSH？SSH是如何工作的？](https://info.support.huawei.com/info-finder/encyclopedia/zh/SSH.html) 也许会解答你的疑问。