# Q139 为什么我在 Windows 系统下无法 `git pull` github 仓库？

## 版本说明

| 时间 | 版本 | 说明 |
| ---- | ---- | ---- |
| 2023-01-16 | 1.0 | 初稿 |

## 解答

`git pull` 的报错内容为：`ssh: connect to host 13.234.176.102 port 22: Connection timed out`。
谷歌搜索以上报错，在 [stack overflow][1] 找到一个类似问题，里面提到可以修改 ssh 配置文件。
这启示我检查 ssh 配置文件。经排查，原因是我之前在 `~/.ssh/config` 配置了以下内容，删除后就可以访问了。

```ssh
Host github.com
  Hostname 13.234.176.102
  Port 22
```

执行 `ssh -T git@github.com`，输出如下：

```text
Hi whl1729! You've successfully authenticated, but GitHub does not provide shell access.
```

执行 `ping github.com`，输出如下：

```text
正在 Ping github.com [20.205.243.166] 具有 32 字节的数据:
请求超时。
```

为什么 ping 不通 github 呢？

ping 是检测两台主机之间的连通性。由于墙的存在，我的主机与 github 服务器不能直接连通，所以 ping 不通是正常的。

那么为什么可以 ssh 连接 github 呢？

这个是通过 socks5 协议实现的，经过代理服务器中转而连接成功的。

那为什么 ping 不能像 ssh 那样连接 github 呢？

因为 ping 工作在网络协议栈第3层（即 IP 层），而 ssh 工作在第7层（即应用层）。
在 IP 层很多事情都做不了，比如说指定一个代理，先连到这个代理，再通过代理连接到 github，这个在 IP 层是无法做到的。

  [1]: https://stackoverflow.com/a/52817036