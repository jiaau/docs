# Cpp Dev

## Environment Setup  

### How to setup Jupyter Notebook for C++ in VS Code

Installation:

[环境配置指南 – Cling 安装配置教程（含安装 Jupyter Kernel）](https://zhuanlan.zhihu.com/p/714759602)

容器内编译可能会遇到的问题： `c++: fatal error: Killed signal terminated program cc1plus`

`cmake --build . -j$(nproc) --config Release && cmake --build . -j$(nproc) --target install`，由于内存资源限制，这里指定的线程数过多时，会造成编译终止，可指定为 4 解决问题。

参考：[unable to build grpc v1.28.1 inside a container](https://stackoverflow.com/questions/62107520/unable-to-build-grpc-v1-28-1-inside-a-container)

Format:

Format c++ code in jupyter notebooks in VS Code.

[Artistic Style](https://astyle.sourceforge.net/astyle.html)

