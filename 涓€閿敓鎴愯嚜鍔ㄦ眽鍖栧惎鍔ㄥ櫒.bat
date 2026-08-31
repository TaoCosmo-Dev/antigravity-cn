@echo off
title Antigravity 智能自动汉化启动�?
echo ========================================================
echo   Antigravity 2.0 智能自动汉化与更新守护配置向�?echo ========================================================
echo.

where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Node.js 运行环境�?    echo.
    echo 汉化引擎需�?Node.js 支持。请按以下步骤操作：
    echo 1. 打开官网下载安装: https://nodejs.org (推荐 LTS 稳定�?
    echo 2. 安装完成后，重新双击运行本脚本即可�?    echo.
    echo ========================================================
    pause
    exit /b 1
)

echo [1/2] 正在注入 Antigravity 全量中文汉化�?..
echo.
node "%~dp0localization_engine.js" --brand-title english

if %errorlevel% neq 0 (
    echo.
    echo [错误] 汉化注入过程中出现异常，请确�?Antigravity 安装路径正确�?    pause
    exit /b 1
)

echo.
echo [2/2] 正在为您创建桌面【Antigravity-CN】自动更新守护启动器...
node "%~dp0make_desktop_shortcut.js"

echo.
echo ========================================================
echo [√] 配置完成�?echo.
echo 您的桌面上已生成【Antigravity-CN】快捷方式�?echo 以后直接从桌面启动即可，官方后台无论更新多少次均会自动保持中文！
echo ========================================================
echo.
pause