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

REM Run the RunFindSpotifyPathAndCreateReg.bat script
call RunFindSpotifyPathAndCreateReg.bat

REM Run the InstallSpotifyProtocolHandler.bat script
call InstallSpotifyProtocolHandler.bat

REM Pause to view any error messages
pause > nul
