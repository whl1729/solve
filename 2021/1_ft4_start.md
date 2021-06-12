# Q1 ft4项目的启动流程是怎样的？

## 修改说明

| 时间 | 版本 | 说明 |
| ---- | ---- | ---- |
| 2021-03-02 | 1.0.0 | 提出问题 |
| 2021-03-07 | 1.0.1 | 解答问题 |

## 解答

1. 主进程执行`src/background.js`，会创建窗口，加载`index.html`文件。
2. `index.html`文件会导入`src/main.js`，该脚本由渲染进程运行，完成Vue相关的功能。
3. 特别注意的是，代码文件index.html中并没有引入`src/main.js`，但使用`vue-cli-plugin-electron-builder`工具编译时，会在index.html增加导入的语句。
4. 我对主进程与渲染进程的分工合作过程不够了解，对js脚本的加载流程也不够了解，需要进一步研究。

## 分析过程

1. ft4项目用到了很多技术
  - electron
  - npm
  - yarn
  - vue
  - element
  - webpack
  - babel

2. 配置文件也有不少
  - babel.config.js
  - vue.config.js
  - package.json

3. 首先，我是执行`yarn electron:serve`来启动流程的。根据package.json的配置，`electron:serve`对应的脚本是`vue-cli-service electron:serve`。这里涉及到四项技术：npm、yarn、electron、vue-cli，让我们逐项突破，即先简单了解各项技术的用法。

4. 通过阅读npm和yarn的介绍文档，得到以下信息：
  - npm，全称为Node Package Manager，是js的一个包管理器。而node是js的一个运行时环境，提供了web服务、网络通信、文件IO、数据流等工具。
  - yarn，全称为Yet Another Resource Negotiator，也是js的一个包管理器，并且是针对npm的一些问题（效率和安全等）进行优化的包管理器。
  - 两者都使用package.json来记录当前代码库依赖的包（package），都使用一个`.lock`文件记录当前代码库使用到的包。注意「依赖」和「使用」的区别：后者是前者的一个子集。

5. 通过阅读electron的介绍文档，得到以下信息：
  - 开发electron程序时，需要在入口脚本中创建一个BrowserWindow对象win，再通过调用`win.loadFile`加载`index.html`
  - 运行electron程序前，需要在`package.json`配置好入口脚本路径（配置main参数的值），以及启动命令（配置scripts参数的值）。

6. 使用google搜索，发现`yarn electron:serve`是一个开源项目`vue-cli-plugin-electron-builder`的用法。

7. 到了星期六，重新分析该问题。先梳理一遍现有进展：
  - 执行`yarn electron:serve`时，会执行到入口脚本`background.js`。（未完全考证，大概率是这样）
  - `background.js`创建window后，加载`public/index.html`。（未研究如何找到public目录的？）
  - `public/index.html`会引入`public/window_node_api.js`。`window_node_api.js`会创建一些全局变量（如electron），并import一些库（如serialport）。
  - `public/index.html`有一句注释：`<!-- built files will be auto injected -->`，这提醒了我：编译构建时可能会在`index.html`插入一些导入js脚本的语句。因此，可能是webpack打包时做了导入某些脚本的工作。接下来需要理解webpack的工作原理。

8. 阅读webpack的Getting Started文档，得到以下信息：
  - webpack会根据src目录下的入口脚本，在dist目录下生成精简后的新脚本。新脚本的名字可在配置文件或index.html中配置。
  - 但ft4的package.json中没有webpack相关命令，根目录下也找不到`webpack.config.js`，因此感觉ft4的主要编译任务不是webpack完成的。剩余的目标可能是babel或`vue-cli-serve build`。之前了解到vue-cli集成了babel。那么应该就是由vue-cli完成编译任务的。

9. 阅读Vue CLI官方文档，得到以下信息：
  - 当执行`vue create xxx`命令时，会创建babel.config.js文件、public目录和src目录。
  - `vue-cli-service serve`的默认入口文件为`src/main.js`，也可以在命令行中提供参数。
  - vue-cli使用`public/index.html`作为一个template.
  - 放置在public目录下的assets可以通过绝对路径来引用。在构建时它们会直接被拷贝到指定目录，而不经过webpack处理。
  - `vue-cli-service build`会将编译结果输出到dist目录，而ft4的结果目录是dist_electron，这应该是使用`vue-cli-service electron:build`的缘故。因此，还得看`electron-builder`。

10. 阅读vue-cli-plugin-electron-builder官方文档，得到以下信息：
  - `electron:build`包含三个主要步骤：render build, main build, and electron-builder build.
  - `electron:serve`也包括三个主要步骤：main build, dev server launch, and electron launch.
  - `src/background.js`是electron entry file (for Electron's main process)
  - `src/main.js`是your app's entry file (for Electron's render process)
  - dist_electron 目录结构
    - bundled: 存放webpack编译后输出的文件
    - `[target platform]-unpacked`: 未打包的Electron app
    - `[application name] setup [version].[target binary (exe|dmg|rpm ...)]`: Electron app的安装程序
    - index.js: 编译后的background file，`electron:serve`的入口脚本。

## 参考资料

1. [creating a package.json file](https://docs.npmjs.com/creating-a-package-json-file)
2. [Yarn: A new package manager for JavaScript](https://engineering.fb.com/2016/10/11/web/yarn-a-new-package-manager-for-javascript/)
3. [Vue CLI Plugin Electron Builder](https://nklayman.github.io/vue-cli-plugin-electron-builder/guide/guide.html)
