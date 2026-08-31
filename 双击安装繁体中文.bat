@echo off
setlocal enabledelayedexpansion
title Antigravity 繁體中文安裝工具

echo ========================================================
echo   Antigravity 2.0 繁體中文一鍵安裝
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
    echo [錯誤] 未檢測到 Antigravity 安裝路徑且系統未安裝 Node.js！
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
%NODE_CMD% "%~dp0localization_engine.js" %BRAND_ARG% --tw

if %errorlevel% neq 0 (
    echo.
    echo [錯誤] 安裝失敗，請檢查錯誤提示。
    pause
    exit /b 1
)

echo.
echo [√] 繁體中文安裝成功！啟動 Antigravity 即可體驗中文介面。
pause
