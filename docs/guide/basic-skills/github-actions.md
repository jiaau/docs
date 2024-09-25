# Github Actions

## Quick Start

[GitHub Actions 快速入门](https://docs.github.com/zh/actions/writing-workflows/quickstart)

## Events that trigger workflows 

[Events that trigger workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows)

## Environment Variables

[Default environment variables](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/store-information-in-variables#default-environment-variables)

[Get current date and time in GitHub workflows](https://stackoverflow.com/questions/60942067/get-current-date-and-time-in-github-workflows)

## Docker

[docker/build-push-action](https://github.com/docker/build-push-action)

[Multi-platform image with GitHub Actions](https://docs.docker.com/build/ci/github-actions/multi-platform/)

[最佳实践-使用Github Actions来构建跨平台容器镜像](https://blog.csdn.net/dweizhao/article/details/134416982)

导出 tar 包，便于后续将其发布到 Github Releases：

[List of output destinations (format: type=local,dest=path)](https://github.com/docker/build-push-action?tab=readme-ov-file#customizing)

[Set the export action for the build result (-o, --output)](https://docs.docker.com/reference/cli/docker/buildx/build/#output)

[Exporters overview](https://docs.docker.com/build/exporters/)

[设置构建结果的输出方式 (-o, --output)](https://www.zhaowenyu.com/docker-doc/reference/dockercmd/dockercmd-docker-buildx-build.html#%E8%AE%BE%E7%BD%AE%E6%9E%84%E5%BB%BA%E7%BB%93%E6%9E%9C%E7%9A%84%E8%BE%93%E5%87%BA%E6%96%B9%E5%BC%8F--o---output)

[My Workflow](https://github.com/whicha/images)

[docker保存、导入、导出和加载tar及其tar.gz](https://blog.csdn.net/qq_31066285/article/details/126267993)

> [!NOTE]
> 
>  [My Workflow](https://github.com/whicha/images) 中通过 Github Releases 发布的 docker tar 包没有元信息，只有通过手动 tag 进行使用：`docker import xxx.tar test:test`

## Github Pages

[Deploy Your VitePress Siteeploy Your VitePress Site](https://vitepress.dev/guide/deploy#github-pages)

[My Workflow](https://github.com/whicha/docs)

## Github Releases

[A GitHub Action for creating GitHub Releases on Linux, Windows, and macOS virtual environments](https://github.com/softprops/action-gh-release)