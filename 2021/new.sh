#!/bin/bash

if [ $# = 0 ]; then
  echo "Usage: $0 filename"
  exit 1
fi

file="$1"
questions="2021_questions.md"
headline=$(cat $questions | egrep ^- | head -1 | awk '{printf "# %s %s\n", $4, $6}')
today=$(date +%Y-%m-%d)

echo "$headline" > "$file"
echo >> "$file"
echo "## 版本说明" >> "$file"
echo >> "$file"
echo "| 时间 | 版本 | 说明 |" >> "$file"
echo "| ---- | ---- | ---- |" >> "$file"
echo "| $today | 1.0 | 初稿 |" >> "$file"
echo >> "$file"
echo "## 解答" >> "$file"
echo >> "$file"
