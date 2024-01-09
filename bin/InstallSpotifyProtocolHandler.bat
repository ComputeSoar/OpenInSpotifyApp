@echo off
REM Check for admin rights
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :runScript
) else (
    echo Administrator permissions required. 
    echo Please run this script as an administrator.
    echo Exiting...
    pause > nul
    exit /b 1
)

:runScript
REM Echo a message indicating that the registry entry is being created
echo Creating Spotify Protocol in Registry...

REM Run the registry file to create the Spotify protocol handler
regedit /s CreateSpotifyProtocolHandler.reg

REM Detect Firefox or Waterfox and set the profile directory
set "FirefoxProfileDir="
set "WaterfoxProfileDir="

for /d %%i in (%APPDATA%\Mozilla\Firefox\Profiles\*.default*) do set "FirefoxProfileDir=%%i"
for /d %%i in (%APPDATA%\Waterfox\Profiles\*.default*) do set "WaterfoxProfileDir=%%i"

REM Copy the SpotifyProtocolHandlerOverrides.js file to the detected profile directory
if defined FirefoxProfileDir (
    echo Firefox Installation Detected.
    copy /Y SpotifyProtocolHandlerOverrides.js "%FirefoxProfileDir%" > nul
    echo // Disable exposing Spotify protocol to the web >> "%FirefoxProfileDir%\user.js"
    echo user_pref("network.protocol-handler.expose.spotify", false); >> "%FirefoxProfileDir%\user.js"
    echo // Allow external applications to handle Spotify protocol >> "%FirefoxProfileDir%\user.js"
    echo user_pref("network.protocol-handler.external.spotify", true); >> "%FirefoxProfileDir%\user.js"
) else if defined WaterfoxProfileDir (
    echo Modified Firefox Installation Detected.
    copy /Y SpotifyProtocolHandlerOverrides.js "%WaterfoxProfileDir%" > nul
    echo // Disable exposing Spotify protocol to the web >> "%WaterfoxProfileDir%\user.js"
    echo user_pref("network.protocol-handler.expose.spotify", false); >> "%WaterfoxProfileDir%\user.js"
    echo // Allow external applications to handle Spotify protocol >> "%WaterfoxProfileDir%\user.js"
    echo user_pref("network.protocol-handler.external.spotify", true); >> "%WaterfoxProfileDir%\user.js"
) else (
    echo Unable to detect Firefox or Waterfox profile directory.
)

echo Completed. Press any key to exit...
pause > nul
