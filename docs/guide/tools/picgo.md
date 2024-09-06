# Using PicGo to Interact with OSS Services

## Installation

[Installation](https://picgo.github.io/PicGo-Core-Doc/zh/guide/getting-started.html)

## Config

[Config](https://picgo.github.io/PicGo-Core-Doc/zh/guide/config.html)

```json
{
  "picBed": {
    "uploader": "aliyun",
    "current": "aliyun",
    "aliyun": {
      "accessKeyId": "",
      "accessKeySecret": "",
      "bucket": "",
      "area": "oss-cn-chengdu",
      "path": "test/",
      "customUrl": "",
      "options": ""
    }
  },
  "picgoPlugins": {}
}
```

> [!IMPORTANT]
> 配置字段不能有省略，否则会报错。以 aliyun 为例，不填的字段应该保留为空字符串，而不能省略。

## Upload Image

[Upload Image](https://picgo.github.io/PicGo-Core-Doc/zh/guide/commands.html#upload-u)

> [!NOTE]
> 使用 `picgo u` 上传剪贴板图片时，如果剪贴板内容非 png 格式的图片，也会上传为 png 格式的图片，从而可能导致非 png 格式图片不可用。这种情况下，你应该将其保存到某个文件夹后，使用 `picgo u <target>` 进行上传。 
> 
> see [通过快捷键上传剪贴板中的图片会导致上传的文件和原文件不同](https://github.com/Molunerfinn/PicGo/issues/99)

### Issues

:::details [linux-wayland-upload-clipboard](https://github.com/PicGo/PicGo-Core/pull/167/files)

wayland 环境下你需要将 `~/.picgo/linux.sh` 内容改为：

```sh
#!/bin/sh
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
  # require xclip(see http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script/677212#677212)
  command -v xclip >/dev/null 2>&1 || { echo >&1 "no xclip"; exit 1; }
  # write image in clipboard to file (see http://unix.stackexchange.com/questions/145131/copy-image-from-clipboard-to-file)
  filePath=`xclip -selection clipboard -o 2>/dev/null | grep ^file:// | cut -c8-`
  if [ ! -n "$filePath" ] ;then
    if
        xclip -selection clipboard -target image/png -o >/dev/null 2>&1
    then
        xclip -selection clipboard -target image/png -o >$1 2>/dev/null
        echo $1
    else
        echo "no image"
    fi
  else
    echo $filePath
  fi
elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  wl-paste > "$1" 2>/dev/null
  echo "$1"
fi
```
:::
