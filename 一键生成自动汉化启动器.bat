@echo off
chcp 65001 >nul
title Antigravity 智能自动汉化启动器生成器

echo ========================================================
echo 正在为您安装 Antigravity 汉化并配置【自动更新守护启动器】...
echo ========================================================
echo.

node "%~dp0localization_engine.js" --brand-title english

if %errorlevel% neq 0 (
    echo.
    echo [错误] 汉化注入失败，请检查是否已安装 Node.js。
    pause
    exit /b 1
)

echo.
echo [1/2] 汉化注入完成！
echo [2/2] 正在创建桌面【自动汉化快捷方式】...

node "%~dp0make_desktop_shortcut.js"

echo.
echo ========================================================
echo [√] 大功告成！
echo 以后请直接从桌面双击【Antigravity-CN】图标启动软件。
echo 官方每次自动更新后，启动器会自动静默重新汉化，无需再手动操作！
echo ========================================================
pause
