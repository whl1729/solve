# Q44 如何使用git rebase解决冲突？

## 修改说明

| 时间 | 版本 | 说明 |
| ---- | ---- | ---- |
| 2021-04-10 | 1.0.0 | 提出问题 |
| 2021-04-26 | 1.0.1 | 解答问题 |

## 解答

- 执行`git rebase <some-branch>` 或者 `git pull --rebase`
- 打开提示冲突的文件，解决冲突，然后执行`git add`，则该文件的冲突已经解决
- 执行`git rebase --continue`，继续解决其他冲突
