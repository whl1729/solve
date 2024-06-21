# Q212 Linux 系统下删除进程已打开的文件会怎样

## 版本说明

| 时间 | 版本 | 说明 |
| ---- | ---- | ---- |
| 2024-06-21 | 1.0 | 初稿，使用 ChatGPT 4 回答此问题 |

## 解答

以下是 ChatGPT 4 的回答（已验证是正确的）：

- 在 Unix-like 系统（例如 Linux、macOS） 中，当一个进程打开一个文件并且这个文件被删除，文件的内容不会立即从磁盘上消失。
  - 实际上，文件的数据块和文件描述符仍然保留在磁盘上，直到最后一个引用文件的进程关闭文件描述符。
  - 在这种情况下，进程A仍然可以继续写入文件，但文件在文件系统目录中不可见。
  - 如果进程A退出，文件描述符会被关闭，此时文件的内容将会被操作系统释放，彻底从磁盘上删除。
- 在 Windows 系统 中，文件被删除后，如果还有进程持有该文件的句柄，则删除操作会失败，进程A仍然可以继续写入文件。

查看已删除文件的内容：

```bash
# 找到进程ID，假如是 1234
ps aux | grep process_a

# 列出进程的所有文件描述符
ls -l /proc/1234/fd/

# 假设文件描述符3指向已删除的文件
# 可以通过文件描述符读取文件内容
cat /proc/1234/fd/3
```

验证代码：

```python
import os
import time
import multiprocessing
from datetime import datetime

def process_a():
    """A进程：每秒写入当前时间戳到output.log"""
    with open("output.log", "w") as f:
        while True:
            current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            f.write(f"{current_time}\n")
            f.flush()  # 确保日志立即写入文件
            time.sleep(1)

def process_b():
    """B进程：等待10秒后删除output.log文件"""
    time.sleep(10)
    if os.path.exists("output.log"):
        os.remove("output.log")
        print("output.log has been deleted")

if __name__ == "__main__":
    # 创建进程A
    p1 = multiprocessing.Process(target=process_a)
    # 创建进程B
    p2 = multiprocessing.Process(target=process_b)

    # 启动进程A
    p1.start()
    # 启动进程B
    p2.start()

    # 等待进程B完成
    p2.join()

    # 进程B完成后不终止进程A，手动停止运行脚本时可以观察效果
    # p1.terminate()
    # p1.join()
  ```
