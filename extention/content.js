// Handle Spotify links and redirect to the Spotify app
console.log('Content script executed!');

var url = window.location.href;

if (url.includes('open.spotify.com/track')) {
  var trackId = url.split('/track/')[1].split('?')[0];
  window.location.href = 'spotify:track:' + trackId;
} else if (url.includes('open.spotify.com/album')) {
  var albumId = url.split('/album/')[1].split('?')[0];
  window.location.href = 'spotify:album:' + albumId;
} else if (url.includes('open.spotify.com/playlist')) {
  var playlistId = url.split('/playlist/')[1].split('?')[0];
  window.location.href = 'spotify:playlist:' + playlistId;
} else if (url.includes('open.spotify.com/artist')) {
  var artistId = url.split('/artist/')[1].split('?')[0];
  window.location.href = 'spotify:artist:' + artistId;
} else {
  window.location.href = 'spotify:' + encodeURIComponent(url);
}
