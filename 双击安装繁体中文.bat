@echo off
title Antigravity 繁體中文安裝工具

echo ========================================================
echo   Antigravity 2.0 繁體中文一鍵安裝
echo ========================================================
echo.

where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [錯誤] 未檢測到 Node.js 運行環境！
    echo 請先前往 https://nodejs.org 下載安裝 Node.js (LTS 版)。
    pause
    exit /b 1
)

echo 請選擇左上角品牌名稱顯示方式：
echo [1] 顯示英文原名 Antigravity (預設推薦)
echo [2] 隱藏左上角品牌文字
echo [3] 顯示中文名稱
set "CHOICE_VAL=1"
set /p "CHOICE_VAL=請輸入選項 [1/2/3] (預設按 Enter 選擇 1): "
set "BRAND_ARG=--brand-title english"
if "%CHOICE_VAL%"=="2" set "BRAND_ARG=--brand-title hidden"
if "%CHOICE_VAL%"=="3" set "BRAND_ARG=--brand-title translated"

echo.
echo 正在執行繁體中文注入...
node "%~dp0localization_engine.js" %BRAND_ARG% --tw

if %errorlevel% neq 0 (
    echo.
    echo [錯誤] 安裝失敗，請檢查錯誤提示。
    pause
    exit /b 1
)

echo.
echo [√] 繁體中文安裝成功！啟動 Antigravity 即可體驗中文介面。
pause
