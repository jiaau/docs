# Lecture 1: Introduction of Deep Learning

## Environment Setup

```sh
(test) ➜  ~ conda install python
Channels:
 - defaults
Platform: linux-64
Collecting package metadata (repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: /root/miniconda3/envs/test

  added / updated specs:
    - python


The following NEW packages will be INSTALLED:

  _libgcc_mutex      pkgs/main/linux-64::_libgcc_mutex-0.1-main
  _openmp_mutex      pkgs/main/linux-64::_openmp_mutex-5.1-1_gnu
  bzip2              pkgs/main/linux-64::bzip2-1.0.8-h5eee18b_6
  ca-certificates    pkgs/main/linux-64::ca-certificates-2024.7.2-h06a4308_0
  expat              pkgs/main/linux-64::expat-2.6.2-h6a678d5_0
  ld_impl_linux-64   pkgs/main/linux-64::ld_impl_linux-64-2.38-h1181459_1
  libffi             pkgs/main/linux-64::libffi-3.4.4-h6a678d5_1
  libgcc-ng          pkgs/main/linux-64::libgcc-ng-11.2.0-h1234567_1
  libgomp            pkgs/main/linux-64::libgomp-11.2.0-h1234567_1
  libstdcxx-ng       pkgs/main/linux-64::libstdcxx-ng-11.2.0-h1234567_1
  libuuid            pkgs/main/linux-64::libuuid-1.41.5-h5eee18b_0
  ncurses            pkgs/main/linux-64::ncurses-6.4-h6a678d5_0
  openssl            pkgs/main/linux-64::openssl-3.0.14-h5eee18b_0
  pip                pkgs/main/linux-64::pip-24.2-py312h06a4308_0
  python             pkgs/main/linux-64::python-3.12.4-h5148396_1
  readline           pkgs/main/linux-64::readline-8.2-h5eee18b_0
  setuptools         pkgs/main/linux-64::setuptools-72.1.0-py312h06a4308_0
  sqlite             pkgs/main/linux-64::sqlite-3.45.3-h5eee18b_0
  tk                 pkgs/main/linux-64::tk-8.6.14-h39e8969_0
  tzdata             pkgs/main/noarch::tzdata-2024a-h04d1e81_0
  wheel              pkgs/main/linux-64::wheel-0.43.0-py312h06a4308_0
  xz                 pkgs/main/linux-64::xz-5.4.6-h5eee18b_1
  zlib               pkgs/main/linux-64::zlib-1.2.13-h5eee18b_1


Proceed ([y]/n)? y


Downloading and Extracting Packages:

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
(test) ➜  ~ python --version
Python 3.12.4
(test) ➜  ~ conda deactivate
(base) ➜  ~ python --version
Python 3.12.4
(base) ➜  ~ conda deactivate
➜  ~ python --version
Python 3.12.5
➜  ~
```

> [!NOTE]
> 从某个环境 deactivate 后会回到 base 环境，但 base 环境也可以 deactivate，base 环境所使用的 python 版本并非系统外通过 pyenv 安装的最新版本。
