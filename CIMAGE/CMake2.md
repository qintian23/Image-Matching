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

## 4 编码

CMake 语言源文件可以用 7 位 ASCII 文本编写，一边在所有支持平台上实现最大的可移植性。换行符可以编码为 `\n` 或者 `\r\n` 单在读取文件时会被转换为换行符 `\n` 。

请注意，该实现是8位干净的，因此在支持这种编码的系统API平台上，源文件可以编码为 UTF-8 。此外，CMake 3.2 及更高版本支持在 Windows 上以 UTF-8 编码的源文件（使用 UTF-16 调用系统API）。此外，CMake 3.0 及更高版本允许在源文件中使用领先的 UTF-8 字节顺序标记。

## 5 源文件

CMake 语言源文件由零个或多个命令调用组成，这些调用由换行符分割，还可以选择空格和注释：

```
file         ::=  file_element*
file_element ::=  command_invocation line_ending |
                  (bracket_comment|space)* line_ending
line_ending  ::=  line_comment? newline
space        ::=  <match '[ \t]+'>
newline      ::=  <match '\n'>
```
请注意，任何不在命令参数或括号注释内的源文件都可以以行注释结尾。

## 6 命令调用

命令调用是一个名称，后跟用空格分割的封闭参数：

```
command_invocation  ::=  space* identifier space* '(' arguments ')'
identifier          ::=  <match '[A-Za-z_][A-Za-z0-9_]*'>
arguments           ::=  argument? separated_arguments*
separated_arguments ::=  separation+ argument? |
                         separation* '(' arguments ')'
separation          ::=  space | line_ending
```

例如：`add_executable(hello world.c)`

命令名称不区分大小写，参数中嵌套的未加引号括号必须平衡。每个 or 都可以作为