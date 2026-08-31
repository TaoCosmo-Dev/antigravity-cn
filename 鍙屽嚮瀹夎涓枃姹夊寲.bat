@echo off
title Antigravity 汉化安装工具

echo ========================================================
echo   Antigravity 2.0 中文汉化一键安�?echo ========================================================
echo.

where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Node.js 运行环境�?    echo 请先前往 https://nodejs.org 下载安装 Node.js (LTS �?�?    pause
    exit /b 1
)

echo 请选择左上角品牌名称显示方式：
echo [1] 显示英文原名 Antigravity (默认推荐)
echo [2] 隐藏左上角品牌文�?echo [3] 显示中文名称 "反重力智能编�?
set "CHOICE_VAL=1"
set /p "CHOICE_VAL=请输入选项 [1/2/3] (默认回车选择 1): "
set "BRAND_ARG=--brand-title english"
if "%CHOICE_VAL%"=="2" set "BRAND_ARG=--brand-title hidden"
if "%CHOICE_VAL%"=="3" set "BRAND_ARG=--brand-title translated"

echo.
echo 正在执行汉化注入...
node "%~dp0localization_engine.js" %BRAND_ARG%

if %errorlevel% neq 0 (
    echo.
    echo [错误] 安装失败，请检查错误提示�?    pause
    exit /b 1
)

echo.
echo [√] 汉化安装成功！启�?Antigravity 即可体验中文界面�?pause