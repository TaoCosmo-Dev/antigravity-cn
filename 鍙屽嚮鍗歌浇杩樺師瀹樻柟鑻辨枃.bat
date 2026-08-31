@echo off
title Antigravity 还原官方英文工具

echo ========================================================
echo   Antigravity 2.0 卸载汉化 / 恢复官方英文
echo ========================================================
echo.

where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Node.js 运行环境�?    pause
    exit /b 1
)

echo 正在还原官方原版英文文件...
node "%~dp0localization_engine.js" --huifu

if %errorlevel% neq 0 (
    echo.
    echo [错误] 还原失败，请确认是否存在 app.asar.bak 官方备份�?    pause
    exit /b 1
)

echo.
echo [√] 官方英文已成功还原！
pause