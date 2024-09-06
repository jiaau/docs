# Quickstart with Ubuntu 22.04 Desktop

## Resources

[Windows11 + Linux (Ubuntu22.04) 双系统最简安装详细避坑版_win11安装linux双系统-CSDN博客](https://blog.csdn.net/2401_84064328/article/details/137232169)

[环境配置指南 – Ubuntu 20.04 杂项（服务器）](https://zhuanlan.zhihu.com/p/700219388)

[环境配置指南 – Ubuntu 22.04 杂项](https://zhuanlan.zhihu.com/p/686485113)

[【保姆级教程】个人深度学习工作站配置指南](https://zhuanlan.zhihu.com/p/336429888)

## 中文输入法配置

备份自 [解决Linux使用fcitx5输入法无法输入问题](https://www.bilibili.com/read/cv21085970/)

1. 下载相关软件

```shell
sudo apt-get install \
    fcitx5-frontend-qt5 \
    fcitx5-frontend-gtk2 \
    fcitx5-frontend-gtk3 \
    fcitx5-pinyin \
    fcitx5-chinese-addons \
    fcitx5-chewing \
    fcitx5-module-lua \
    fcitx5-module-lua-common \
    fcitx5-modules \
    unicode-cldr-core 
```

**依赖解释：**

fcitx5-frontend-qt5/fcitx5-qt - 为fcitx5输入法提供Qt5 IM模块。

fcitx5-frontend-gtk2/fcitx5-gkt - 为fcitx5输入法提供GTK2 IM模块。

fcitx5-frontend-gtk3/fcitx5-gtk - 为fcitx5输入法提供GTK3 IM模块。

fcitx5-pinyin - 为fcitx5输入法框架提供拼音支持。

fcitx5-chinese-addons - 为fcitx5输入法提供中文相关插件。

fcitx5-chewing - 为fcitx5输入法提供chewing繁体中文输入引擎。

fcitx5-module-lua/fcitx5-lua - 为fcitx5输入法提供lua支持。

fcitx5-module-lua-common/fcitx5-lua - 为fcitx5输入法提供lua支持的通用文件。

fcitx5-modules - fcitx5输入法框架的核心模块。

unicode-cldr-core/unicode-cldr - 来自Unicode CLDR的核心通用数据。 

2. 配置文件

在 `/etc/environment` 文件中输入如下内容：

```shell
XIM=fcitx5
XIM_PROGRAM=fcitx5
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
XMODIFIERS=@im=fcitx5
SDL_IM_MODULE=fcitx5
GLFW_IM_MODULE=fcitx5
```

3. 使得配置文件生效

在 root 用户下使用如下命令：

```shell
source /etc/environment
```

4. 重启计算机

```shell
sudo reboot now
```

## Tips & Tricks

[What is the correct way to completely remove an application?](https://askubuntu.com/questions/187888/what-is-the-correct-way-to-completely-remove-an-application)


