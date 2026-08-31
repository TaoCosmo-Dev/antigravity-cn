@echo off
setlocal enabledelayedexpansion
title Antigravity 智能自动汉化启动器

echo ========================================================
echo   Antigravity 2.0 智能自动汉化与更新守护配置向导
echo ========================================================
echo.

:: 1. 检测 Node 运行环境（优先系统 Node，无 Node 时自动借用 Antigravity 内置引擎）
set "NODE_CMD="
where node >nul 2>&1
if %errorlevel% equ 0 (
    set "NODE_CMD=node"
) else (
    set "CAND[0]=%LOCALAPPDATA%\Programs\antigravity\Antigravity.exe"
    set "CAND[1]=%LOCALAPPDATA%\Programs\Antigravity IDE\Antigravity.exe"
    set "CAND[2]=%ProgramFiles%\Antigravity\Antigravity.exe"
    set "CAND[3]=%ProgramFiles(x86)%\Antigravity\Antigravity.exe"
    set "CAND[4]=C:\Programs\Antigravity\Antigravity.exe"
    set "CAND[5]=D:\Programs\Antigravity\Antigravity.exe"
    set "CAND[6]=E:\Programs\Antigravity\Antigravity.exe"
    
    for /L %%i in (0,1,6) do (
        if not defined NODE_CMD (
            if exist "!CAND[%%i]!" (
                set "NODE_CMD="!CAND[%%i]!""
                set "ELECTRON_RUN_AS_NODE=1"
            )
        )
    )
)

if not defined NODE_CMD (
    echo [错误] 未检测到 Antigravity 安装路径且系统未安装 Node.js！
    echo 请先安装 Antigravity，或前往 https://nodejs.org 安装 Node.js。
    pause
    exit /b 1
)

echo [1/2] 正在注入 Antigravity 全量中文汉化包...
echo.
%NODE_CMD% "%~dp0localization_engine.js" --brand-title english

if %errorlevel% neq 0 (
    echo.
    echo [错误] 汉化注入失败，请检查上方报错。
    pause
    exit /b 1
)

echo.
echo [2/2] 正在为您创建桌面【Antigravity-CN】自动更新守护启动器...
%NODE_CMD% "%~dp0make_desktop_shortcut.js"

echo.
echo ========================================================
echo [√] 配置完成！
echo.
echo 您的桌面上已生成【Antigravity-CN】快捷方式。
echo 以后直接从桌面启动即可，官方后台无论更新多少次均会自动保持中文！
echo ========================================================
echo.
pause
