# Quickstart with Ubuntu 22.04 Desktop

## Resources

[Windows11 + Linux (Ubuntu22.04) 双系统最简安装详细避坑版_win11安装linux双系统-CSDN博客](https://blog.csdn.net/2401_84064328/article/details/137232169)

[环境配置指南 – Ubuntu 20.04 杂项（服务器）](https://zhuanlan.zhihu.com/p/700219388)

[环境配置指南 – Ubuntu 22.04 杂项](https://zhuanlan.zhihu.com/p/686485113)

[【保姆级教程】个人深度学习工作站配置指南](https://zhuanlan.zhihu.com/p/336429888)


## Chinese input method

[解决Linux使用fcitx5输入法无法输入问题](https://www.bilibili.com/read/cv21085970/)

### 1 下载相关软件

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

### 2 配置文件

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

### 3 使得配置文件生效

在 root 用户下使用如下命令：

```shell
source /etc/environment
```

### 4 重启计算机

```shell
sudo reboot now
```

## GNOME plugins

如果你此前并未安装过 GNOME 插件，你需要先使用 APT 安装 GNOME Shell Extensions：

```bash
sudo apt install gnome-shell-extensions
```

然后根据你的浏览器安装对应的浏览器插件。Firefox 可以在[这里](https://addons.mozilla.org/zh-CN/firefox/addon/gnome-shell-integration/)安装，Chrome 可以在[这里](https://chromewebstore.google.com/detail/gnome-shell-%E9%9B%86%E6%88%90/gphhapmejobijbbhgpjhcjognlahblep)安装。

> Edge 也可安装 Chrome 插件

为了使浏览器插件可以正常工作，你还需要安装 `chrome-gnome-shell`——尽管名称里有“Chrome”，但它也可以用于 Firefox：

```bash
sudo apt install chrome-gnome-shell
```

（仅对于 Ubuntu 23.04 及以上版本的用户）如果你使用 Ubuntu 23.04 及以上版本，`chrome-gnome-shell` 已更名为 `gnome-browser-connetor`，你可以使用以下命令安装：

```bash
sudo apt install gnome-browser-connetor
```

**⚠️ 提示:** Ubuntu 22.04 默认通过 Snap 安装的 Firefox 可能有兼容性问题导致 GNOME 插件无法正常工作——如果你遇到了此类问题，可以试试用 Chrome 安装。

GNOME 插件可在[这里](https://extensions.gnome.org/)找到。实际上你直接按下载量从高到低看下去就能根据你的喜好找到你需要安装哪些插件了，但你可能希望一些建议。以下是我个人的一些推荐：

- [Vitals](https://extensions.gnome.org/extension/1460/vitals/)：在顶栏显示系统信息，如 CPU 温度、内存使用情况等。
- [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)：在一些地方加上了毛玻璃效果，比如顶栏和切换工作区时的预览窗口。
- [Pano](https://extensions.gnome.org/extension/5278/pano/)：一个剪贴板管理器。值得注意的是该插件需要安装 GSound，你可以根据 [GitHub 仓库中的相关说明](https://link.zhihu.com/?target=https%3A//github.com/oae/gnome-shell-pano%3Ftab%3Dreadme-ov-file%23installation)安装。

不常用：

- [User Themes](https://extensions.gnome.org/extension/19/user-themes/)：允许你使用 GNOME Tweaks 安装的主题。实话说，我从不安装自定义主题，原生的对我来说就够了，所以我一般不装。
- [Dash to Panel ](https://extensions.gnome.org/extension/1160/dash-to-panel/)或 [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)：根据你的习惯，将 Dash 栏换成 Windows 风格的任务栏或 macOS 风格的 Dock 栏。值得注意的是截至本文编写时，Dash to Panel 仍不支持 Wayland.
- [Application Menu](https://extensions.gnome.org/extension/6/applications-menu/)：在顶栏显示“应用程序”菜单，使得你可以在顶栏中直接打开应用程序。
- [Caffeine](https://extensions.gnome.org/extension/517/caffeine/)：在顶栏显示一个咖啡杯图标，点击即可阻止屏幕自动关闭。如果你以往需要频繁在设置中切换屏幕自动关闭的状态，这个插件可能会很有用。
- [Places Status Indicator](https://extensions.gnome.org/extension/8/places-status-indicator)：在顶栏显示文件菜单（显示为“位置”），使得你可以在顶栏中直接打开文件。
- [No activities button](https://extensions.gnome.org/extension/3184/no-activities-button/)：禁用左上角的“活动”按钮。


## Python installation

各个配置文件对应的 shell。

```txt
WARNING: seems you still have not added 'pyenv' to the load path.

# Load pyenv automatically by appending
# the following to
# ~/.bash_profile if it exists, otherwise ~/.profile (for login shells)
# and ~/.bashrc (for interactive shells) :

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Restart your shell for the changes to take effect.

# Load pyenv-virtualenv automatically by adding
# the following to ~/.bashrc:

eval "$(pyenv virtualenv-init -)"
```

