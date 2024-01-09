@echo off
REM Check for admin rights
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :runUninstall
) else (
    echo Administrator permissions required. 
    echo Please run this script as an administrator.
    echo Exiting...
    pause > nul
    exit /b 1
)

:runUninstall
REM Confirm with the user before proceeding with the uninstallation
echo This script will uninstall the Spotify Protocol Handler modifications.
set /p "confirmation=Do you want to continue? (Y/N): "

if /i "%confirmation%" neq "Y" (
    echo User chose not to continue. Exiting...
    pause > nul
    exit /b 0
)

REM Revert registry changes
echo Reverting registry changes...

REM Navigate to the "bin" directory
cd "%~dp0bin"

REM Run the UninstallSpotifyProtocolHandler.reg script
regedit /s UninstallSpotifyProtocolHandler.reg

REM Detect Firefox or Waterfox and set the profile directory
set "FirefoxProfileDir="
set "WaterfoxProfileDir="

for /d %%i in (%APPDATA%\Mozilla\Firefox\Profiles\*.default*) do set "FirefoxProfileDir=%%i"
for /d %%i in (%APPDATA%\Waterfox\Profiles\*.default*) do set "WaterfoxProfileDir=%%i"

REM Remove the user.js file from the detected profile directory
if defined FirefoxProfileDir (
    del /q "%FirefoxProfileDir%\SpotifyProtocolHandlerOverrides.js"
    echo Uninstalled from Firefox. Press any key to exit...
) else if defined WaterfoxProfileDir (
    del /q "%WaterfoxProfileDir%\SpotifyProtocolHandlerOverrides.js"
    echo Uninstalled from Waterfox. Press any key to exit...
) else (
    echo Unable to detect Firefox or Waterfox profile directory.
)

REM Pause to view any error messages
pause > nul
