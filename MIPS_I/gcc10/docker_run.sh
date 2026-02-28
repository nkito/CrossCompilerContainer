#!/bin/sh

# Git リポジトリのトップディレクトリを取得
TOPLEVEL=$(git rev-parse --show-toplevel 2>/dev/null)

if [ $? -eq 0 ]; then
    echo "リポジトリのトップディレクトリ: $TOPLEVEL"
else
    echo "エラー: カレントディレクトリは Git リポジトリ内にありません"
    exit 1
fi

uid=$(id -u)
gid=$(id -g)

docker run -it --rm -v $TOPLEVEL:/src -u $uid:$uid mips1sdk_gcc10
