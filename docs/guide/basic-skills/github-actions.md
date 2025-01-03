# Github Actions

## Quick Start

[GitHub Actions 快速入门](https://docs.github.com/zh/actions/writing-workflows/quickstart)

[About workflows](https://docs.github.com/en/actions/writing-workflows/about-workflows)

> Workflows are defined in the .github/workflows directory in a repository. A repository can have multiple workflows, each which can perform a different set of tasks

## Events that trigger workflows 

[Events that trigger workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows)

## Environment Variables

[Default environment variables](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/store-information-in-variables#default-environment-variables)

[Get current date and time in GitHub workflows](https://stackoverflow.com/questions/60942067/get-current-date-and-time-in-github-workflows)

## Docker

### My Workflow

[My Workflow](https://github.com/jiaau/images)

> [!WARNING]
> 
>  不同分支下 workflow 名称相同（非 yml 文件名称相同）时，即使触发事件发生，workflow 可能也不会启动。

[docker/build-push-action](https://github.com/docker/build-push-action)

[Multi-platform image with GitHub Actions](https://docs.docker.com/build/ci/github-actions/multi-platform/)

[最佳实践-使用Github Actions来构建跨平台容器镜像](https://blog.csdn.net/dweizhao/article/details/134416982)

### Writes all result files as a single tarball on the client

导出 tar 包，便于后续将其发布到 Github Releases：

[List of output destinations (format: type=local,dest=path)](https://github.com/docker/build-push-action?tab=readme-ov-file#customizing)

[Set the export action for the build result (-o, --output)](https://docs.docker.com/reference/cli/docker/buildx/build/#output)

[Exporters overview](https://docs.docker.com/build/exporters/)

[设置构建结果的输出方式 (-o, --output)](https://www.zhaowenyu.com/docker-doc/reference/dockercmd/dockercmd-docker-buildx-build.html#%E8%AE%BE%E7%BD%AE%E6%9E%84%E5%BB%BA%E7%BB%93%E6%9E%9C%E7%9A%84%E8%BE%93%E5%87%BA%E6%96%B9%E5%BC%8F--o---output)

[docker保存、导入、导出和加载tar及其tar.gz](https://blog.csdn.net/qq_31066285/article/details/126267993)

> [!NOTE]
> 
> 未正确设置可能导致由 tarball 导入得到的 Docker image 不可用，故工作流中换成了从 Docker Hub 拉取 Docker image，再导出为 tarball 这种方式。

其他工作流参考：

[快速构建指定架构/平台的docker镜像](https://github.com/wukongdaily/DockerTarBuilder/tree/master)

## Github Pages

### My Workflow

[My Workflow](https://github.com/jiaau/docs)

[Deploy Your VitePress Siteeploy Your VitePress Site](https://vitepress.dev/guide/deploy#github-pages)

## Github Releases

### My Workflow

[My Workflow](https://github.com/jiaau/images)

[A GitHub Action for creating GitHub Releases on Linux, Windows, and macOS virtual environments](https://github.com/softprops/action-gh-release)