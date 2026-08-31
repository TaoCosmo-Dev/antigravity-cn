#!/bin/bash
cd "$(dirname "$0")"
echo "====== 正在安裝 macOS 版 Antigravity 繁體中文 ======"

which node >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "[錯誤] 未檢測到 Node.js 運行環境！"
    echo "請前往 https://nodejs.org 下載安裝 Node.js 後重試。"
    read -n 1 -s
    exit 1
fi

echo "請選擇左上角品牌顯示方式："
echo "[1] 顯示英文 Antigravity（推薦）"
echo "[2] 不顯示品牌名"
echo "[3] 顯示中文品牌名"
printf "請輸入 1/2/3，直接按 Enter 預設 1: "
read -r BRAND_CHOICE
BRAND_ARG="--brand-title english"
if [ "$BRAND_CHOICE" = "2" ]; then
    BRAND_ARG="--brand-title hidden"
elif [ "$BRAND_CHOICE" = "3" ]; then
    BRAND_ARG="--brand-title translated"
fi

node localization_engine.js $BRAND_ARG --tw "$@"

if [ $? -ne 0 ]; then
    echo ""
    echo "運行失敗！請檢查上方錯誤資訊。"
    read -n 1 -s
    exit 1
fi

echo ""
echo "處理完成。視窗將在 5 秒後自動關閉..."
read -t 5 -n 1 -s
