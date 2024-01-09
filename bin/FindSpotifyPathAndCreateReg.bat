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

REM Display a loading message
echo Searching for Spotify.exe...

REM Define common installation locations for Spotify
set "CommonPaths=%ProgramFiles%\Spotify\Spotify.exe %ProgramFiles(x86)%\Spotify\Spotify.exe"

REM Attempt to find the path to Spotify.exe
for %%i in (%CommonPaths%) do (
    if exist "%%i" (
        set "SpotifyPath=%%~dpi"
        echo Spotify.exe found at: %%i
        goto :FoundSpotify
    )
)

echo Unable to automatically find Spotify.exe.
echo Exiting...
pause > nul
exit /b 1

:FoundSpotify
REM Create the .reg file
echo Windows Registry Editor Version 5.00 > "%~dp0CreateSpotifyProtocolHandler.reg"
echo [HKEY_CLASSES_ROOT\spotify] >> "%~dp0CreateSpotifyProtocolHandler.reg"
echo @="URL:Spotify Protocol" >> "%~dp0CreateSpotifyProtocolHandler.reg"
echo "URL Protocol"="" >> "%~dp0CreateSpotifyProtocolHandler.reg"
echo. >> "%~dp0CreateSpotifyProtocolHandler.reg"
echo [HKEY_CLASSES_ROOT\spotify\DefaultIcon] >> "%~dp0CreateSpotifyProtocolHandler.reg"
echo @=hex(2):25,53,70,6f,74,69,66,79,50,61,74,68,25,5c,53,70,6f,74,69,66,79,2e,65,78,65,2c,30,00 >> "%~dp0CreateSpotifyProtocolHandler.reg"
echo. >> "%~dp0CreateSpotifyProtocolHandler.reg"
echo [HKEY_CLASSES_ROOT\spotify\shell] >> "%~dp0CreateSpotifyProtocolHandler.reg"
echo. >> "%~dp0CreateSpotifyProtocolHandler.reg"
echo [HKEY_CLASSES_ROOT\spotify\shell\open] >> "%~dp0CreateSpotifyProtocolHandler.reg"
echo. >> "%~dp0CreateSpotifyProtocolHandler.reg"
echo [HKEY_CLASSES_ROOT\spotify\shell\open\command] >> "%~dp0CreateSpotifyProtocolHandler.reg"
echo @="\"%SpotifyPath%Spotify.exe\" %%1" >> "%~dp0CreateSpotifyProtocolHandler.reg"

echo Registry entries created.

REM Pause to view any error messages
pause > nul
