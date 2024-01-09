// SpotifyProtocolHandlerOverrides.js

(function () {
    console.log('Script executed!');
    
    // Set security.external_protocol_requires_permission to false
    try {
        Services.prefs.setBoolPref("security.external_protocol_requires_permission", false);
    } catch (e) {
        console.error('Error setting security.external_protocol_requires_permission:', e);
    }

    // Rest of your existing code...
    var spotifyLinkRegex = /open\.spotify\.com\/(track|album|artist)\/([^/?]+)/;
    var match = window.location.href.match(spotifyLinkRegex);

    if (match) {
        var type = match[1];
        var id = match[2];

        var spotifyURI = 'spotify:' + type + ':' + id;
        window.location.href = spotifyURI;
    }
})();
