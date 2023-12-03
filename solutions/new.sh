#!/bin/bash

if [ $# = 0 ]; then
  echo "Usage: $0 filename"
  exit 1
fi

readonly SOLUTION_DIR="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P)"
readonly QUESTION_DIR="${SOLUTION_DIR}/../questions/"
#echo "SOLUTION_DIR: ${SOLUTION_DIR}"
#echo "QUESTION_DIR: ${QUESTION_DIR}"

readonly YEAR="$(cd ${SOLUTION_DIR}; ls -d */ | tail -1)"
#echo "YEAR: ${YEAR}"
readonly OUTPUT_FILE="${SOLUTION_DIR}/${YEAR}/$1"
#echo "OUTPUT_FILE: ${OUTPUT_FILE}"

IFS="_" read -ra FILENAMES <<< "$1"
readonly QUESTION_ID="${FILENAMES[0]}"
#echo "QUESTION_ID: ${QUESTION_ID}"

readonly HEADLINE="$(cat ${QUESTION_DIR}/*_questions.md | grep "Q${QUESTION_ID}" | head -1 | sed 's/- \[ \] \([^ ]\+\) [^ ]\+ \(.*\)/# \1 \2/g' | sed 's/[?？]//g')"
readonly TODAY="$(date +%Y-%m-%d)"

echo -e "${HEADLINE}" > "${OUTPUT_FILE}"
echo >> "${OUTPUT_FILE}"
echo "## 版本说明" >> "${OUTPUT_FILE}"
echo >> "${OUTPUT_FILE}"
echo "| 时间 | 版本 | 说明 |" >> "${OUTPUT_FILE}"
echo "| ---- | ---- | ---- |" >> "${OUTPUT_FILE}"
echo "| ${TODAY} | 1.0 | 初稿 |" >> "${OUTPUT_FILE}"
echo >> "${OUTPUT_FILE}"
echo "## 解答" >> "${OUTPUT_FILE}"

echo "Create file ok: ${OUTPUT_FILE}"
