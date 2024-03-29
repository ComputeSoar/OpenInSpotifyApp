@echo off
REM Check for admin rights
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :confirm
) else (
    echo Administrator permissions required. 
    echo Please run this script as an administrator.
    echo Exiting...
    pause > nul
    exit /b 1
)

:confirm
echo This script will modify your Firefox or Waterfox installation to open Spotify links in the desktop app.
set /p "confirmation=Do you want to continue? (Y/N): "

if /i "%confirmation%" neq "Y" (
    echo User chose not to continue. Exiting...
    pause > nul
    exit /b 0
)

REM Navigate to the "bin" directory
cd "%~dp0bin"

REM Open about:debugging#/runtime/this-firefox in default browser
start firefox https://addons.mozilla.org/firefox/downloads/file/4219402/dd19f06cb57f46658b85-1.0.xpi

REM Wait for 2 seconds to allow Firefox to open
timeout /t 2 /nobreak >nul

REM Check if Firefox is running, if not, try Waterfox
tasklist /FI "IMAGENAME eq firefox.exe" 2>NUL | find /I /N "firefox.exe" >NUL
if "%ERRORLEVEL%"=="0" (
    REM Firefox is running
) else (
    REM Suppress error messages and try opening URLs in Waterfox
    2>NUL timeout /t 2 /nobreak >nul
    2>NUL start waterfox https://addons.mozilla.org/firefox/downloads/file/4219402/dd19f06cb57f46658b85-1.0.xpi
    timeout /t 2 /nobreak >nul
)

REM Display a message
echo Please load the extension in your browser. Once done, press any key to exit...

REM Pause to view any error messages
pause > nul
