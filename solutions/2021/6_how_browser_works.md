# Q6: 浏览器的工作原理是怎样的？

## 修改说明

| 时间 | 版本 | 说明 |
| ---- | ---- | ---- |
| 2021-03-06 | 1.0.0 | 提出问题 |
| 2021-03-07 | 1.0.1 | 初次分析 |

## 明确问题

当我问浏览器的工作原理时，我究竟想问什么？

首先看下：关于浏览器，我已经知道哪些东西。

- 浏览器最核心的工作是为用户提供浏览网页的功能。
- 为实现这个功能，浏览器首先需要获得网页数据。这些网页数据可能来自本地，也可能来自远端服务器。无论哪种情况，都可以通过URL地址来标记网页位置。
- URL地址一般提供的是域名，而网络通信时需要的是IP地址。因此一般需要通过DNS服务器来将域名转换为IP。
- 为获取这些数据，浏览器需要支持各种通信协议，最常见的是http(s)协议。
- 网页数据一般包括html、css和js等文件，以及图片、音频、视频等多媒体数据。
- 获取到这些网页数据后，浏览器需要将它们恰当地呈现出来。（或者说渲染）

我目前主要不理解的地方是：**浏览器是如何渲染html/css/js的？** （这个问题与Q5有点重复，可以一并解决）

以及，听说浏览器一般有主进程和渲染进程之分，那么它们是如何分工合作的？

## 参考资料

1. [Critical rendering path](https://developer.mozilla.org/en-US/docs/Web/Performance/Critical_rendering_path)
2. [How Browsers Work: Behind the scenes of modern web browsers](https://www.html5rocks.com/en/tutorials/internals/howbrowserswork/)
