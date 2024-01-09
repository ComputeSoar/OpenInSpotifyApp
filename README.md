# OpenInSpotifyApp

Redirects Spotify links to automatically open in the desktop app when clicked.

## Installation

1. Run `Install.bat` to set up the necessary registry entries.
2. Load the extension by selecting "Load Temporary Add-On..." on the page that has opened in your browser. (If this page does not load, navigate to: `about:debugging#/runtime/this-firefox`.)
3. The `extension` folder should have been automatically opened upon running `Install.bat`, load the `manifest.json` file as a Temporary Add-On.

**Note:** Before running scripts or installing browser extensions from external sources, be cautious and ensure that they come from trustworthy and reliable sources to avoid potential security risks.

## How it works

- The logic files create registry entries to associate Spotify links with the Spotify app.
- The browser extension redirects Spotify web links to the Spotify app.

## Requirements

- Windows operating system
- Mozilla Firefox or Waterfox browser

## Troubleshooting

If the extension does not work as expected, try the following steps:

1. Ensure that the Spotify app is installed on your system.
2. Check that the registry entries created by the batch script are correct.
3. Make sure the browser extension is loaded correctly in the browser.

## License

This project is licensed under the [MIT License](LICENSE).

Feel free to contribute or report issues!
