#!/bin/bash

if [ $# = 0 ]; then
  echo "Usage: $0 filename"
  exit 1
fi

readonly FILE="$1"
readonly QUESTIONS="2022_questions.md"
readonly HEADLINE="$(cat ${QUESTIONS} | grep -E ^- | head -1 | sed 's/- \[ \] \([^ ]\+\) [^ ]\+ \(.*\)/# \1 \2/g')"
readonly TODAY="$(date +%Y-%m-%d)"

echo -e "$HEADLINE" > "$FILE"
echo >> "$FILE"
echo "## 版本说明" >> "$FILE"
echo >> "$FILE"
echo "| 时间 | 版本 | 说明 |" >> "$FILE"
echo "| ---- | ---- | ---- |" >> "$FILE"
echo "| $TODAY | 1.0 | 初稿 |" >> "$FILE"
echo >> "$FILE"
echo "## 解答" >> "$FILE"
