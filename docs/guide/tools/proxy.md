# Proxy Settings

## Desktop

桌面版使用均需开启 `System Proxy` 才可代理浏览器的请求。

在 `Proxies` 模式介绍：

- `Rule` 仅代理墙外请求，墙内请求不经过代理。

- `Global` 代理所有请求。

在 `Profiles` 处填写订阅链接。

### Windows

[下载链接](https://github.com/whicha/docs/releases/download/clash/Clash.for.Windows-0.20.39-win.7z)

### Ubuntu

[下载链接](https://github.com/whicha/docs/releases/download/clash/clash-verge_1.3.8_amd64.deb)

## Command Line Tools

[在 Linux 中使用 Clash](https://blog.iswiftai.com/posts/clash-linux/)

[在 Linux 中使用 Clash](https://uyaki.github.io/posts/proxy/%E5%9C%A8linux%E4%B8%AD%E4%BD%BF%E7%94%A8clash/)

> [!IMPORTANT]
> 
> 仅适用于 Linux 平台。

### Installation

[下载链接](https://github.com/whicha/docs/releases/download/clash/clash-linux-amd64-v1.18.0.gz)

[备用链接](https://github.com/opusb/clash/releases)

使用 `gnuzip` 命令进行解压缩：

```sh
gnuzip <xxx.gz>
```

```sh
mv <xxx> clash
```

启动：

```sh
clash
```

> [!NOTE]
> 
> 可能需要添加执行权限。

> Clash 运行时需要 Country.mmdb 文件，当第一次启动 Clash 时（使用 ./clash 命令） 会自动下载（会下载至 /home/XXX/.config/clash 文件夹下）。自动下载可能会因网络原因较慢，可以访问该 [链接](https://github.com/Dreamacro/maxmind-geoip/releases) 手动下载。

> Country.mmdb 文件利用 GeoIP2 服务能识别互联网用户的地点位置，以供规则分流时使用。

### Configuration

[在 Linux 通过 cli 使用 Clash](https://docs.gtk.pw/contents/linux/clash-cli.html#%E4%BF%AE%E6%94%B9%E9%85%8D%E7%BD%AE-config)

访问如下链接（由订阅链接 + `&&flag=clash` 构成）：

```txt
https://154.23.185.44/api/v1/client/subscribe?token=469d79525d931118fc1ac8b7fc3700cb&&flag=clash
```

```sh
mv <file_you_get> /home/<user>/.config/clash/config.yaml
```

:::tip TIP
为避免与 Desktop 版本端口发生冲突，可修改以下两个属性的值：

```yaml
mixed-port: 7891
external-controller: '127.0.0.1:9091'
```
:::

> [!TIP]
> 
> 如果你安装有 clash 桌面版，在 `Profiles` 处填写订阅链接，可在 `~/.config/clash-verge/clash-verge.yaml` 获取到相同 profile 。


### Usage

启动 clash

在你的 shell file ，如  `.zshrc` 中输入以下内容：

```sh
# >>> proxy >>>
proxy() {
  proxy_host='127.0.0.1'
  proxy_port=7891
  http_proxy_url="http://$proxy_host:$proxy_port"
  socks5_proxy_url="socks5://$proxy_host:$proxy_port"

  export http_proxy=$http_proxy_url
  export HTTP_PROXY=$http_proxy_url
  export https_proxy=$http_proxy_url
  export HTTPS_PROXY=$http_proxy_url
  export all_proxy=$socks5_proxy_url
  export ALL_PROXY=$socks5_proxy_url
}

unproxy() {
  unset http_proxy
  unset HTTP_PROXY
  unset https_proxy
  unset HTTPS_PROXY
  unset all_proxy
  unset ALL_PROXY
}
# <<< proxy <<<
```

刷新 shell file：

```sh
source ~/.zshrc
```

需要请求代理时：

```sh
proxy
```

使用完毕时：

```sh
unproxy
```

> [!NOTE]
> 
> 这种使用方式下，不能代理浏览器请求。