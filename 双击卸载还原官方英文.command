#!/bin/bash
cd "$(dirname "$0")"
echo "====== 正在还原官方原版英文 ======"

which node >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "[错误] 未检测到 Node.js 运行环境！"
    read -n 1 -s
    exit 1
fi

node localization_engine.js --huifu "$@"

if [ $? -ne 0 ]; then
    echo ""
    echo "还原失败！"
    read -n 1 -s
    exit 1
fi

echo ""
echo "官方英文已成功还原！窗口将在 5 秒后自动关闭..."
read -t 5 -n 1 -s
