# Specify the path where Spotify is installed
$appDataPath = Join-Path $env:APPDATA "Spotify\Spotify.exe"

# Check if Spotify.exe exists in the specified path
if (Test-Path $appDataPath) {
    # Replace single backslashes with double backslashes in the path
    $appDataPath = $appDataPath -replace '\\', '\\'

    # Create the .reg file content
    $regContent = @"
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\spotify]
@="URL:Spotify Protocol"
"URL Protocol"=""

[HKEY_CLASSES_ROOT\spotify\DefaultIcon]
@="\"$appDataPath\",0"

[HKEY_CLASSES_ROOT\spotify\shell\open\command]
@="\"$appDataPath\" %1"

[HKEY_CLASSES_ROOT\.spotify]
@="spotify"

[HKEY_CLASSES_ROOT\spotify\shell\open\command]
@="\"$appDataPath\" \"%1\""

[HKEY_CLASSES_ROOT\http\shell\open\command]
@="\"$appDataPath\" \"%1\""

[HKEY_CLASSES_ROOT\https\shell\open\command]
@="\"$appDataPath\" \"%1\""
"@

    # Save the .reg content to a file
    $regPath = Join-Path $PSScriptRoot "CreateSpotifyProtocolHandler.reg"
    $regContent | Out-File -Encoding ASCII -FilePath $regPath

    # Import the .reg file to add entries to the registry
    Invoke-Expression -Command "reg import `"$regPath`""

    Write-Host "Registry entries created and values set."
}
else {
    Write-Host "Unable to find Spotify.exe in the specified path. Exiting..."
    exit 1
}
