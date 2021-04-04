var httpRequest;

var makeRequest = function() {
  document.getElementById('background-video').play();
  var $text = document.querySelector('#generator h1');
  var sayings = ['Thinking', 'Pondering', 'Confused', 'Deciding', 'Bored', 'Excited', 'Curious', 'Predicting'];

  httpRequest = new XMLHttpRequest();
  httpRequest.onreadystatechange = alertContents;
  httpRequest.open('GET', 'movie');
  httpRequest.send();

  var saySomething = function() {
    $text.style.opacity = 0;

    setTimeout(function() {
      $text.textContent = sayings[Math.floor(Math.random() * sayings.length)];
      $text.style.opacity = 1;
    }, 2000);
  }

  saySomething();
  setInterval(saySomething, 4000);
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
