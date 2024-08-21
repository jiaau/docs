# VSCode + TexLive in Ubuntu2204 installed by WSL2

## TexLive 安装
[Index of /CTAN/systems/texlive/Images/ | 清华大学开源软件镜像站 | Tsinghua Open Source Mirror](https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/Images/)  

```shell
sudo mkdir /mnt/texlive
sudo mount /mnt/d/texlive2024.iso /mnt/texlive
```

```shell
sudo /mnt/texlive/install-tl
# 输入 I 回车
```

```shell
code ~/.bashrc
```

```shell
# Add TeX Live to the PATH, MANPATH, INFOPATH
export PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH
```

```shell
sudo umount /mnt/texlive	# 注意不是unmount!
sudo rm -r /mnt/texlive
```

```shell
tex -v
```
## 字体设置
```shell
sudo apt install fontconfig
```

```shell
sudo cp /usr/local/texlive/2024/texmf-var/fonts/conf/texlive-fontconfig.conf /etc/fonts/conf.d/09-texlive.conf
```

```shell
sudo ln -s /mnt/c/Windows/Fonts /usr/share/fonts/font
```

```shell
sudo fc-cache -fsv
```

## LaTeX Workshop 配置
[优雅的使用LaTeX | latexshop使用方法 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/521256466) 

```json
{
    /* latex-workshop setup begin*/
    "latex-workshop.view.pdf.internal.synctex.keybinding": "double-click", //设置反向搜索的方式为双击
    "latex-workshop.showContextMenu": true, //启用上下文LaTeX菜单
    "latex-workshop.latex.autoBuild.run": "never", //手动编译
    "latex-workshop.message.error.show": true,
    "latex-workshop.message.warning.show": false,
    "latex-workshop.intellisense.package.enabled": true, //根据加载的包，自动完成命令或包
    "latex-workshop.latex.recipes": [
        {
            "name": "xelatex",
            "tools": [
                "xelatex"
            ]
        },
        {
            "name": "xelatex ->bibtex -> xelatex*2",
            "tools": [
                "xelatex",
                "bibtex",
                "xelatex",
                "xelatex"
            ]
        },
        {
            "name": "pdflatex",
            "tools": [
                "pdflatex"
            ]
        }
    ],
    "latex-workshop.latex.tools": [
        {
            "name": "xelatex",
            "command": "xelatex",
            "args": [
                "-shell-escape",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-output-driver=xdvipdfmx",
                "-file-line-error",
                "%DOC%"
            ]
        },
        {
            "name": "pdflatex",
            "command": "pdflatex",
            "args": [
                "-shell-escape",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOC%"
            ]
        },
        {
            "name": "bibtex",
            "command": "bibtex",
            "args": [
                "%DOCFILE%"
            ]
        }
    ],
    // 清除辅助文件
    "latex-workshop.latex.clean.fileTypes": [
        "*.aux",
        "*.bbl",
        "*.blg",
        "*.idx",
        "*.ind",
        "*.lof",
        "*.lot",
        "*.out",
        "*.toc",
        "*.acn",
        "*.acr",
        "*.alg",
        "*.glg",
        "*.glo",
        "*.gls",
        "*.ist",
        "*.fls",
        "*.fdb_latexmk"
    ],
    "latex-workshop.latex.autoClean.run": "onBuilt",
    /* latex-workshop setup end*/
}
```

[Fireond/BiliBili-Repo: VsCode与Latex相关配置文件 (github.com)](https://github.com/Fireond/BiliBili-Repo) 

```json
[
    /* latex-workshop setup begin*/
    // 正向搜索
    {
        "key": "ctrl+alt+u",
        "command": "latex-workshop.synctex",
        "when": "editorTextFocus && !config.latex-workshop.bind.altKeymap.enabled && !virtualWorkspace && editorLangId == 'latex'"
    },
]
```

## 踩坑

### eps无法编转换

[WSL中编译latex文档遇到问题：eps无法编转换，报错信息为“xdvipdfmx warning could not open conversion result XX for image XX”程序中缺少 ghostscript 组件-CSDN博客](https://blog.csdn.net/complexmind/article/details/127248992) 

```shell
sudo apt update
sudo apt install ghostscript
```

## 使用

需要在确定文章类型的命令中加入fontset=windows，否则即使指定了正文字体（如宋体），仍会使用原来的FandolSong字体。

```latex
\documentclass[fontset=windows,12pt]{article} %eg.1

\RequirePackage[zihao=-4,UTF8,heading=true,fontset=windows]{ctex}[2016/12/27] %eg.2
```

## 参考

[install-latex-guide-zh-cn.pdf (ctan.org)](https://tug.ctan.org/info/install-latex-guide-zh-cn/install-latex-guide-zh-cn.pdf) 

[TeX Live 2024 安装教程（Windows/WSL/Linux） - Eslzzyl - 博客园 (cnblogs.com)](https://www.cnblogs.com/eslzzyl/p/17358405.html) 

[理工科电脑记笔记最强方案——vscode+wsl+latex_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1CG4y1L7p9/?spm_id_from=333.337.search-card.all.click&vd_source=28c1733f23da877f7a7ff03ab05b2a54) 