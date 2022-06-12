# Q123 如何理解 CORS 错误？

## 版本说明

| 时间 | 版本 | 说明 |
| ---- | ---- | ---- |
| 2022-06-11 | 1.0 | 初稿 |

## 问题描述

- 按照[electron-vue][1]的「Getting Started」一章的方法，创建了一个项目样板。
- 在项目的`src/renderer/components/LandingPage.vue`文件中，使用 axios 向网站 `pa.minieye.tech` 发送请求。
- 在终端执行命令`npm run dev`，会弹出界面，点击其中按钮，触发上述 axios 请求后，会报错：

  ```text
  Failed to load http://pa.minieye.tech/: No 'Access-Control-Allow-Origin' header is present on the requested resource.
  Origin 'http://localhost:9080' is therefore not allowed access.
  ```

- 在终端执行命令`npm run build`，并运行打包后的 exe 文件，则不会报错。

## 解决过程

### 理解开发模式与生产模式的差异

开发模式下会监听本地的 9080 端口，生产模式下则不会监听端口，这里可以提出两个问题：

1. 为什么前者会导致 CORS errors，后者则不会？
2. 为什么开发模式下要监听本地的 9080 端口，而不是跟生产模式一样？

问题1与我们的目标更相关，问题2只是一个延伸的问题。因此我们首先考虑问题1.

为解决问题1，首先需要理解 CORS 是什么。

### 理解 CORS

#### CORS 是什么

以下摘自[MDN web docs 对「跨源资源共享(CORS)」的解释][2]：

> 跨源资源共享 (CORS, Cross-Origin Resource Sharing)（或通俗地译为跨域资源共享）是一种基于 HTTP 头的机制，
> 该机制通过允许服务器标示除了它自己以外的其它 origin（域，协议和端口），使得浏览器允许这些 origin 访问加载自己的资源。
> 跨源资源共享还通过一种机制来检查服务器是否会允许要发送的真实请求，该机制通过浏览器发起一个到服务器托管的跨源资源的"预检"（preflight）请求。
> 在预检中，浏览器发送的头中标示有 HTTP 方法和真实请求中会用到的头。

MDN web docs 还提到浏览器对跨源 HTTP 请求的限制：

> 出于安全性，浏览器限制脚本内发起的跨源 HTTP 请求。例如，XMLHttpRequest 和 Fetch API 遵循同源策略。
> 这意味着使用这些 API 的 Web 应用程序只能从加载应用程序的同一个域请求 HTTP 资源，除非响应报文包含了正确 CORS 响应头。

我有以下疑问：

1. 为什么要限制脚本内发起的跨源 HTTP 请求？具体有什么安全问题？
2. 平时浏览网站可以随意点击超链接，为什么这种跨源请求没被限制？

#### SOP

第一个疑问可以从 SOP (Same-Origin Policy) 的出发点来寻找答案。

根据[MDN web docs 对「Same-Origin Policy」的解释][3]，SOP 可以减少被攻击的风险：

> It helps isolate potentially malicious documents, reducing possible attack vectors.
> For example, it prevents a malicious website on the Internet from running JS in a browser
> to read data from a third-party webmail service (which the user is signed into) or a company intranet
> (which is protected from direct access by the attacker by not having a public IP address) and relaying that data to the attacker.

维基百科词条「Same-Origin Policy」给出了 SOP 能够防止部分攻击的一个例子：

> The same-origin policy protects against reusing authenticated sessions across origins.
> The following example illustrates a potential security risk that could arise without the same-origin policy.
> Assume that a user is visiting a banking website and doesn't log out.
> Then, the user goes to another site that has malicious JavaScript code that requests data from the banking site.
> Because the user is still logged in on the banking site, the malicious code could do anything the user could do on the banking site.
> For example, it could get a list of the user's last transactions, create a new transaction, etc.
> This is because, in the original spirit of a world wide web,
> browsers are required to tag along authentication details
> such as session cookies and platform-level kinds of the Authorization request header
> to the banking site based on the domain of the banking site.
>
> The bank site owners would expect that regular browsers of users visiting the malicious site
> do not allow the code loaded from the malicious site access the banking session cookie or platform-level authorization.
> While it is true that JavaScript has no direct access to the banking session cookie,
> it could still send and receive requests to the banking site with the banking site's session cookie.
> Same Origin Policy was introduced as a requirement for security-minded browsers to deny read access to responses from across origins,
> with the assumption that the majority of users choose to use compliant browsers.
> The policy does not deny writes.
> Counteracting the abuse of the write permission requires additional CSRF protections by the target sites.

为理解这个例子，需要先理解 [cookie][4] 的原理。

为

  [1]: https://github.com/SimulatedGREG/electron-vue
  [2]: https://developer.mozilla.org/zh-CN/docs/Web/HTTP/CORS
  [3]: https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy
  [4]: https://en.wikipedia.org/wiki/HTTP_cookie
