@echo off
setlocal enabledelayedexpansion
title Antigravity 汉化安装工具

echo ========================================================
echo   Antigravity 2.0 中文汉化一键安装
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

echo 请选择左上角品牌名称显示方式：
echo [1] 显示英文原名 Antigravity (默认推荐)
echo [2] 隐藏左上角品牌文字
echo [3] 显示中文名称 "反重力智能编程"
set "CHOICE_VAL=1"
set /p "CHOICE_VAL=请输入选项 [1/2/3] (默认回车选择 1): "
set "BRAND_ARG=--brand-title english"
if "%CHOICE_VAL%"=="2" set "BRAND_ARG=--brand-title hidden"
if "%CHOICE_VAL%"=="3" set "BRAND_ARG=--brand-title translated"

echo.
echo 正在执行汉化注入...
%NODE_CMD% "%~dp0localization_engine.js" %BRAND_ARG%

if %errorlevel% neq 0 (
    echo.
    echo [错误] 安装失败，请检查错误提示。
    pause
    exit /b 1
)

echo.
echo [√] 汉化安装成功！启动 Antigravity 即可体验中文界面。
pause
