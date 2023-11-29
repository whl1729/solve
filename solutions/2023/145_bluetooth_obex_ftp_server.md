# Q145 Ubuntu 系统如何提供 bluetooth obex ftp 服务

## 版本说明

| 时间 | 版本 | 说明 |
| ---- | ---- | ---- |
| 2023-03-01 | 1.0 | 初稿 |

## 解答

## 思路

- 首先理解三个概念：bluetooth、obex、ftp。
- 然后搞清楚 ubuntu 的蓝牙模块是怎么工作的，尤其是需要启动哪些服务
  - 搞清楚 bluez、bluetoothd、obexd、openobex 和 obexftpd 等软件的关系
- 还有使用 `bt-obex -f` 进行 ftp 通信时会报错，需要调查清楚，很可能与 obexftpd 无法通信是相同的原因。

### bluez、bluetoothd

- Ubuntu Core 有两个蓝牙协议栈的接口：bluetooth-control 和 bluez，其中 bluez 默认是没安装的。
- bluez 包括有 L2CAP、RFCOMM 和 SDP 等模块。
- 安装 bluez 时会安装 /usr/bin/bluetoothctl 和 /usr/lib/bluetooth/bluetoothd，这么看 bluetoothctl 可能是用来跟 bluetoothd 通信的。
- bluetoothd 是管理蓝牙设备的后台程序。

### obexd

- 安装 bluez-tools 时会安装 bluez-obexd、bt-adapter、bt-device 和 bt-network 等工具。
- 根据蓝牙协议栈，OBEX 是工作在 RFCOMM 之上的，做个简单的类比，RFCOMM 相当于传输层的 TCP/UDP，而 OBEX 相当于应用层的 HTTP。
- 那么也可以这么理解：bluetoothd 是管理传输层的服务，obexd 是管理应用层的服务。
- `bt-obex -f`进入 ftp 会话后，执行上传文件命令会报错，如下所示。
  - 从报错信息来看，很可能是 obexd 不支持 ftp 协议，这跟我昨天查阅到的 obex 的源码行为是一致的。
  - [bluez-tools][3] 的官网介绍中，也提到 FTP会话在输入 `ls` 后会崩溃的问题。

  ```bash
  > mkdir /tmp/ftp
  GDBus.Error:org.freedesktop.DBus.Error.UnknownMethod: Method "CreateFolder" with signature "s" on interface "org.bluez.obex.FileTransfer" doesn't exist

  > put README .
  (bt-obex:88132): GLib-CRITICAL **: 14:57:37.589: g_variant_ref_sink: assertion 'value != NULL' failed

  (bt-obex:88132): GLib-CRITICAL **: 14:57:37.589: g_variant_unref: assertion 'value != NULL' failed
  GDBus.Error:org.freedesktop.DBus.Error.UnknownMethod: Method "PutFile" with signature "ss" on interface "org.bluez.obex.FileTransfer" doesn't exist
  ```

### openobex

- openobex 应该算是 bluez-tools 的一个替代方案。
- kill 掉 obexd 进程后，使用 obexftpd 可以上传文件了，但上传完 obexftpd 又把文件删除了，日志打印如下所示：

  ```bash
  along:~/Documents/ft/dfh3/src/obexftp$ obexftpd -b 10 -c ~/Downloads/
  Waiting for connection...
  obex_event() OBEX_EV_REQCHECK: mode=01, obex_cmd=00, obex_rsp=00
  Incoming request 00
  \obex_event() OBEX_EV_REQDONE: obex_rsp=00
  obex_event() OBEX_EV_REQCHECK: mode=01, obex_cmd=02, obex_rsp=00
  |obex_ev_progress: obex_cmd_put
  put_done>>>
  put_done () Skipped header cb
  put file name: minieye.txt
  HEADER_LENGTH = 15
  Got a PUT without a body
  Incoming request 02
  Received PUT command
  put_done>>>
  Got a PUT without a body
  Deleting file minieye.txt
  <<<put_done
  /obex_ev_progress: obex_cmd_put
  put_done>>>
  Got a PUT without a body
  Got a PUT without a name. Setting name to OBEX_PUT_Unknown_object
  obex_event() OBEX_EV_REQDONE: obex_rsp=00
  obex_event() OBEX_EV_REQCHECK: mode=01, obex_cmd=01, obex_rsp=00
  Incoming request 01
  -obex_event() OBEX_EV_REQDONE: obex_rsp=00
  failed: 0
  obexftpd reset
  Waiting for connection...
  ```

### bluetooth

- 目前为止，关于蓝牙我知道什么？
  - 蓝牙是一种无线通信技术，要求距离较近，一般10米以内
  - 目前手机、笔记本一般都支持蓝牙，部分耳机和车载设备等也支持蓝牙

- 目前为止，关于蓝牙我不知道什么？
  - 蓝牙使用的无线电频段是多少？
  - 蓝牙与wifi有哪些区别？
  - 蓝牙的协议是怎样的？
  - 蓝牙收发器的硬件与wifi收发器的硬件有什么区别？

- 蓝牙基础知识
  - 蓝牙使用的频段是：2.402 ~ 2.48 GHz
  - 蓝牙的标准是：Bluetooth SIG standards
  - 蓝牙与wifi的一些区别：前者是WPAN（无线个人网），后者是WLAN（无线局域网），后者的覆盖范围更大；前者双向，后者一般单向等等。
  - 蓝牙协议栈：windows 8 以后使用 BLE（Bluetooth Low Energy），Linux 使用 BlueZ。
  - 蓝牙传输速率：Bluetooth 4.0 最高是 1 Mbps，Bluetooth 5.0 最高是 2 Mbps。

- 蓝牙软件架构
  - LMP: Link Management Protocol。管理两个设备之间的无线电链路、查询设备功能和电源管理等。
  - HCI: Host Controller Interface。主机协议栈与控制器之间的通信接口。HCI 传输层标准包括 USB、UART 等。
  - SDP: Service discovery protocol。用来发现可通信范围内的其他蓝牙设备以及它们支持的功能。
  - RFCOMM: Radio Frequency Communication。用来模拟串口通信（RS-232）。
  - TCS: Telephony control protocol。用来建立和控制蓝牙设备之间的语音和数据通话。
  - L2CAP: Logical Link Control and Adaptation Protocol。负责分包与组包。
  - OBEX: Object Exchange。用来规范设备之间二进制数据的通信。

- 蓝牙硬件架构
  - 无线设备。用来调制和发送信号。
  - 数字控制器。类似CPU，负责运行链路控制器和与主机设备交互等。
  - 链路控制器负责处理基带数据、管理ARQ和FEC协议、数据传输、音频编码、数据加密等。

- 蓝牙协议栈
  - 蓝牙协议栈分为两部分
    - 控制器协议栈：对时间精度要求高的无线电接口。包括 LMP 和 HCI 等。
    - 主机协议栈：处理高层数据。包括 L2CAP、RFCOMM、SDP、TCS 和 OBEX 等。
  - 所有蓝牙协议栈必须支持的协议是：LMP、L2CAP 和 SDP。
  - 跟蓝牙通信的设备一般使用的协议是：HCI 和 RDCOMM。

### obex

- 目前为止，关于 OBEX 我知道什么？
  - OBEX 全称是 Object Exchange。
  - Ubuntu 系统下有个 bt-obex 工具，可以通过蓝牙接收文件。

- 目前为止，关于 OBEX 我不知道什么？
  - OBEX 是一个协议？这个协议包括什么内容？
  - OBEX 与 FTP 有什么关系？

- OBEX
  - OBEX 与 HTTP 在设计和功能上类似，都是为客户端与服务端之间的连接和收发数据提供一套协议。
  - OBEX 与 HTTP 的区别在于
    - OBEX 工作在 Base/ACL/L2CAP/RFCOMM 之上，而非 TCP/IP 之上。
    - OBEX 使用二进制格式的数据，HTTP 使用文本数据。
    - OBEX 单个连接可能做多个操作。
  - OBEX 的 Object 是 fields 和 headers.

- OBEX 是许多高层的 profiles 的基础，包括 OPP 和 FTP 等

- OBEX 协议
  - OPP: OBEX Object Push Profile
  - FTP: OBEX File Transfer Protocol (or Profile)

- OBEX 实现
  - OpenObex

### FTP

- 目前为止，关于 FTP 我知道什么？
  - OBEX FTP 跟平时说的 FTP 应该有所差异。
  - FTP 全称是 File Transfer Protocol，文件传输协议。顾名思义，用于收发文件。
  - FTP 服务的端口是 21.

- 目前为止，关于 FTP 我不知道什么？
  - FTP 是工作在 TCP/IP 之上的吧？
  - FTP 协议是怎样的？

## 参考资料

- [wiki: bluetooth][1]
- [wiki: OBject EXchange][2]
- [bluez-tools][3]
- [github: openobex][4]
- [wiki: openobex][5]

  [1]: https://en.wikipedia.org/wiki/Bluetooth
  [2]: https://en.wikipedia.org/wiki/OBject_EXchange
  [3]: https://code.google.com/archive/p/bluez-tools/
  [4]: https://github.com/zuckschwerdt/openobex
  [5]: http://dev.zuckschwerdt.org/openobex/wiki/

