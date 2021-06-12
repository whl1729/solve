# Q3 git内部是怎样实现的？

## 修改说明

| 时间 | 版本 | 说明 |
| ---- | ---- | ---- |
| 2021-03-03 | 1.0.0 | 提出问题 |
| 2021-04-30 | 1.0.1 | 解答问题 |

## 解答

这个问题问得有点泛，让我们问得具体些：git是如何实现版本管理的？

这个问题可以在《Pro Git》找到答案。

- git可以视为一个提供了版本管理功能的文件系统，也可以视为一个数据库。git的数据保存在当前仓库根目录下的`.git`目录中。git的大部分操作实际上就是对`.git`目录下的文件进行增删查改。
- 对git而言，一个版本就是一个commit。而一个commit包含有某次提交记录的基本信息（who, when, commit message, previous commit），以及这次提交后的所有文件内容。
- 这时就涉及到一个问题，git是如何存储数据的？
  - 当你创建一个新文件时，git 会将该文件经过处理后保存在`.git/objects`目录下。处理过程如下：首先为该文件生成一个header（包含object类型及长度这两个信息），然后和文件内容合并，对合并后的数据计算出SHA1校验和，作为保存的文件名；对合并后的数据进行压缩，作为保存的文件内容。
- git里面最常见的object有3种：blob, commit, tree，分别对应文件、提交记录、文件夹。此外还有tag等。
- 上面说到，每次commit都记录了本次提交后的所有文件内容，如何记录的呢？事实上，每个commit对象都指向一个tree对象（每个commit都记录有一个tree对象的SHA1校验和），这个tree对象又指向若干个tree对象和blob对象，类似文件系统的树结构。
- git分支其实只是一个「指针」，指向一个commit对象。创建一个本地分支develop，就是在`.git/refs/head`目录下创建一个名字叫develop的文件，文件的内容就是某个commit对象的SHA1校验和。也就是说，一个git分支其实只是一个含有40个字节的文件！
- `.git/HEAD`文件一般用来记录当前处于哪个分支，当然你也可以checkout某个tag或者任意一次commit，这时HEAD会指向对应的commit对象，git也会提示`You are in 'detached HEAD' state`
- 最后简单说下常见git操作与`.git`目录之间的联系
  - `git add`会在`.git/objects`目录下创建一个新文件，对应一个blob对象。
  - `git commit`会在`.git/objects`目录下创建一个新文件，对应一个commit对象。
  - `git branch -a`会在`.git/refs`目录下创建一个新文件，里面记录一个commit对象的SHA1校验和。
  - `git checkout`会修改`.git/HEAD`文件，使其执行新的commit对象。
