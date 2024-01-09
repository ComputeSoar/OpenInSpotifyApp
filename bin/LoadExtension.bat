@echo off
setlocal enabledelayedexpansion

REM Get the current script directory
set "ScriptDir=%~dp0"

REM Use the detected paths for Firefox or Waterfox
set "ExtensionPath=%ScriptDir%extension"  REM Set the path to your extension folder

REM Detect Firefox
for /d %%i in (%APPDATA%\Mozilla\Firefox\Profiles\*.default*) do set "FirefoxProfileDir=%%i"
for /d %%i in (%APPDATA%\Waterfox\Profiles\*.default*) do set "WaterfoxProfileDir=%%i"

REM Choose the first detected profile directory
set "ProfileDir="
if defined FirefoxProfileDir set "ProfileDir=!FirefoxProfileDir!"
if defined WaterfoxProfileDir set "ProfileDir=!WaterfoxProfileDir!"

if not defined ProfileDir (
    echo Unable to detect Firefox or Waterfox profile directory.
    exit /b 1
)

REM Copy the extension files to the profile extension directory
xcopy /s /y "!ExtensionPath!\*" "!ProfileDir!\extensions\"

echo Extension loaded successfully.

endlocal
