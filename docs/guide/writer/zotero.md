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
sudo ./set_launcher_icon
```

```sh
sudo ln -s /opt/zotero/zotero.desktop ~/.local/share/applications/zotero.desktop
```

## Configuration

在 `编辑` -> `设置` -> `高级` -> `数据存储位置` 处修改到同步的文件夹。


## Syncthing

非 root 用户在 Linux 下使用 [Syncthing](../tools/syncthing.md) 同步时可能存在权限问题，下面开启服务定时刷新同步文件夹权限：

```sh
sudo vim /etc/systemd/system/zotero.service
```

输入以下内容：

```txt
[Unit]
Description=zotero sync
After=syslog.target network.target
Wants=network.target

[Service]
User=root
ExecStart=sudo chmod -R 777 /home/<user>/Workspace/Zotero

RestartSec=5
Restart=always

[Install]
WantedBy=multi-user.target
```

启动服务：

```sh
sudo systemctl enable zotero.service
```

```sh
sudo systemctl start zotero.service
```

查看状态：

```sh
sudo systemctl status zotero.service;
```