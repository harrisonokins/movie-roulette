var httpRequest;

var makeRequest = function() {
  httpRequest = new XMLHttpRequest();
  httpRequest.onreadystatechange = alertContents;
  httpRequest.open('GET', 'movie');
  httpRequest.send();
}

var alertContents = function() {
  if (httpRequest.readyState === XMLHttpRequest.DONE) {
    if (httpRequest.status === 200) {
      data = JSON.parse(httpRequest.responseText);
      window.open(data.url, '_self');
    } else {
      alert('What we\'ve got here is a failure to communicate.');
    }
  }
}

document.addEventListener('DOMContentLoaded', (event) => {
  document.getElementById('generator').addEventListener('click', makeRequest);
});
