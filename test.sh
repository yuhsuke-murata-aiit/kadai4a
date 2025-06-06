#!/bin/bash

usage()
{
    cat <<EOF
Usage: $0 <テストデータファイル> 
EOF
}

# 引数チェック
if [ $# -lt 1 ]; then
    echo "テストデータファイルが指定されていません。"
    usage
    exit 1
fi

if ! [ -f "$1" ]; then
    echo "指定されたテストデータファイルが存在しません。"
    usage
    exit 1
fi

file="$1"

# テストデータファイル（csv形式）読み込み
# 1列目（自然数#1）、2列目（自然数#2）、3列目（期待する結果）読み込み
while IFS=, read -r col1 col2 col3;
do
    if [ ${#col1} -eq 0 ]; then
    continue
fi
    firstChar="$col1"
    if [ "${firstChar:0:1}" = "#" ]; then
        echo ""
        echo ""
        echo $col1
        continue

    fi
    echo "---------- 最大公約数シェルスクリプト(gcd.sh)出力 ----------"
    result=$(bash ./gcd.sh "$col1" "$col2")
    if [ $? -eq 0 ]; then
        IFS=$'\n' read -r -d '' -a lines < <(printf '%s\0' "$result")
        upperLines="${lines[*]:0:${#lines[@]}-1}"
        lastLine="${lines[-1]}"

        status="NG"
        if [ "$lastLine" = "$col3" ]; then
            status="OK"
        fi

        echo $upperLines
        echo $lastLine
        echo "---------- テスト結果 ----------"
        echo "入力値：自然数#1 =" $col1 "自然数#2 =" $col2
        echo "期待値：" $col3 " 演算結果：" $lastLine " 結果：" $status
    else
        status="NG"
        if [ "NG" = "$col3" ]; then
            status="OK"
        fi

        echo $result
        echo "---------- テスト結果 ----------"
        echo "入力値：自然数#1 =" $col1 "自然数#2 =" $col2
        echo "期待値：" $col3 " 結果：" $status
    fi
done < "$file"

echo ""
echo ""
echo "#引数が無いケース"
result=$(bash ./gcd.sh)
echo ""
echo ""
echo "#引数が1つのケース"
resylt=$(bash ./gcd.sh "1")
echo ""
echo ""
echo "#引数が3つのケース"
resylt=$(bash ./gcd.sh "1" "2" "3")

exit 0

