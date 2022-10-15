# cmake 语法

CMake 输入文件以 “CMake 语言” 写入名为 CMakeList.txt 文件扩展名或以 .cmake 文件扩展名结尾的源文件中。

CMake 语言源文件分为以下组织：

* Directories ( CMakeLists.txt ) 目录
* Scripts ( \<script \>.cmake ) 脚本
* Modules ( \<module \>.cmake ) 模块

## 1 目录

当 CMake 处理项目源代码树时，入口点是在顶级源目录中调用的源文件 CMakeList.txt 。此文件可能包含整个生成规范，或使用 `add_subdirectory() ` 命令向 build 添加子目录。该命令添加的每个子目录还必须包含一个CMakeList.txt 文件作为该目录的入口点。对于处理 CMakeList.txt 文件的每个源目录，CMake 都会在生成树中生成一个相应的目录，以充当默认的工作目录和输出目录。

## 2 脚本

单个 \<script \>.cmake 源文件可以在脚本模式下使用带有该选项的 cmake 命令行工具进行处理。脚本模式仅运行给定 CMake 语言源文件中的命令，而不是生成 生成系统。 它不允许定义生成目标或操作的 CMake 命令。

## 3 模块

目录或脚本中的 CMake 语言代码可以使用 include() 命令在包含上下文的范围内加载 \<module \>.cmake 源文件。请参阅 [ cmake-modules(7)](https://cmake.org/cmake/help/latest/manual/cmake-modules.7.html#manual:cmake-modules(7)) 手册页，了解 CMake 发行版中包含的模块的文档。项目源代码树还可以提供自己的模块，并在 `CMAKE_MODULE_PATH` 变量中指定它们的位置。