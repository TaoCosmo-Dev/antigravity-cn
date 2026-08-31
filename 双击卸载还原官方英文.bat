@echo off
setlocal enabledelayedexpansion
title Antigravity 还原官方英文工具

echo ========================================================
echo   Antigravity 2.0 卸载汉化 / 恢复官方英文
echo ========================================================
echo.

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
    pause
    exit /b 1
)

echo 正在还原官方原版英文文件...
%NODE_CMD% "%~dp0localization_engine.js" --huifu

if %errorlevel% neq 0 (
    echo.
    echo [错误] 还原失败，请确认是否存在 app.asar.bak 官方备份。
    pause
    exit /b 1
)

echo.
echo [√] 官方英文已成功还原！
pause
