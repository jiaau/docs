# Git

## 基本配置

```sh
git config --global core.editor vim
```

## 常用操作

### 避免重复输入密码

> [!TIP]
> 
> 如果你正在使用 HTTPS URL 来推送，Git 服务器会询问用户名与密码。 默认情况下它会在终端中提示服务器是否允许你进行推送。
> 
> 如果不想在每一次推送时都输入用户名与密码，你可以设置一个 “credential cache”。 最简单的方式就是将其保存在内存中几分钟，可以简单地运行 git config --global credential.helper cache 来设置它。
> 
> 想要了解更多关于不同验证缓存的可用选项，查看 [凭证存储](https://git-scm.com/book/zh/v2/Git-%E5%B7%A5%E5%85%B7-%E5%87%AD%E8%AF%81%E5%AD%98%E5%82%A8#_credential_caching)。

[Add a PAT (Personal Access Token) ](https://stackoverflow.com/questions/68775869/message-support-for-password-authentication-was-removed)

### 重写 commit 历史

[Git 常用操作 | 重写 commit 历史](https://blog.csdn.net/sD7O95O/article/details/108505028)

### possible to push to the remote

[possible to push to the remote](https://stackoverflow.com/a/76212777/26612416)