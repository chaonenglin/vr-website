@echo off
echo ========================================
echo   GitHub 连接检测
echo ========================================
echo.

:: 检测代理端口是否在监听
netstat -an 2>nul | findstr "7890" | findstr "LISTENING" >nul 2>&1
if %errorlevel%==0 (
    echo [OK] FlClash 代理端口 7890 已开启
    echo.
    echo 正在测试 GitHub 连接...
    curl -s --max-time 10 -x http://127.0.0.1:7890 https://github.com -o nul -w "GitHub 状态: HTTP %%{http_code}\n"
    echo.
    echo 代理可用，git 已自动配置走代理。
    echo 以后只要开着 FlClash，git push/pull 都会自动走代理。
) else (
    echo [!!] FlClash 代理端口 7890 未开启
    echo.
    echo 请打开 FlClash，点击"系统代理"开关打开代理。
    echo 打开后重新运行此脚本检测。
)
echo.
pause
