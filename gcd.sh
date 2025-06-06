#!/bin/bash

MAX="9223372036854775807"

usage()
{
    echo "Usage: $0 <自然数#1> <自然数#2>" 1>&2
}

# 引数の数をチェック
if [ $# -ne 2 ]; then
    echo "引数の数(= $#)が正しくありません。" 1>&2
    usage
    exit 1
fi

# 引数1が自然数かチェック
if ! [[ $1 =~ ^[1-9][0-9]*$ ]]; then
    echo "引数1が自然数ではありません。" 1>&2
    usage
    exit 1
fi

# 引数1の最大値チェック
val=$1
if [[ ${#val} -gt ${#MAX} || (${#val} -eq ${#MAX} && "$val" > "$MAX") ]]; then
    echo "引数1が最大値（9,223,372,036,854,775,807）を超えています。" 1>&2
    usage
    exit 1
fi

# 引数2が自然数かチェック
if ! [[ $2 =~ ^[1-9][0-9]*$ ]]; then
    echo "引数2が自然数ではありません。" 1>&2
    usage
    exit 1
fi

# 引数2の最大値チェック
val=$2
if [[ ${#val} -gt ${#MAX} || (${#val} -eq ${#MAX} && "$val" > "$MAX") ]]; then
    echo "引数2が最大値（9,223,372,036,854,775,807）を超えています。" 1>&2
    usage
    exit 1
fi

# 引数を内部変数に設定
a=$1
b=$2

# a < b の場合、abの値を入れ替え
if [ "$a" -lt "$b" ]; then
    temp=$a
    a=$b
    b=$temp
fi

# ユークリッドの互除法で最大公約数を求める
while [ "$b" -ne 0 ];
do
    temp=$b
    b=$(( a % b ))
    a=$temp
done

echo "$1 と$2の最大公約数:"
echo "$a"
exit 0
