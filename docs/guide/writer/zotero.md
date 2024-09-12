# Zotero

## Installation

### Linux

```sh
sudo tar -xjvf Zotero-7.0.5_linux-x86_64.tar.bz2 -C /opt/zotero
```

```sh
cd /opt/zotero
sudo cp -r ./Zotero_linux-x86_64/. ./
sudo rm -rf ./Zotero_linux-x86_64
```

```sh
cd /opt/zotero
./set_launcher_icon
```

```sh
ln -s /opt/zotero/zotero.desktop ~/.local/share/applications/zotero.desktop
```

## Configuration

在 `编辑` -> `设置` -> `高级` -> `数据存储位置` 处修改到同步的文件夹。