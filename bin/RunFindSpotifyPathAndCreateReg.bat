@echo off
REM Check for admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Administrator permissions required. 
    echo Please run this script as an administrator.
    echo Exiting...
    pause > nul
    exit /b 1
)

REM Run the PowerShell script
powershell -ExecutionPolicy Bypass -File "%~dp0FindSpotifyPathAndCreateReg.ps1"