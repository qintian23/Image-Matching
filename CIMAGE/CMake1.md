# CMAKE 1

## CMakeList.txt 结构

```
生成一个项目生成系统
 cmake [<options>] <path-to-source | path-to-existing-build>
 cmake [<options>] -S <path-to-source> -B <path-to-build>

构建一个项目
 cmake --build <dir> [<options>] [-- <build-tool-options>]

安装一个项目
 cmake --install <dir> [<options>]

打开一个项目
 cmake --open <dir>

运行一个脚本
 cmake [-D <var>=<value>]... -P <cmake-script-file>

运行一个命令行工具
 cmake -E <command> [<options>]

运行查找包工具
 cmake --find-package [<options>]

运行一个工作流预置
 cmake --workflow [<options>]

查看帮助
 cmake --help[-<topic>]
```

## 命令行制作工具

