# Q145 Ubuntu 系统如何提供 bluetooth obex ftp 服务

## 解答

## 思路

首先理解三个概念：bluetooth、obex、ftp。

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

- OBEX 协议
  - OPP: OBEX Push Profile
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
