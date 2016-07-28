// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
//

import select2 from "select2"
import Edit from "./crop"

$("select").select2()

var fileSelect = document.getElementById("fileSelect"),
    fileElem = document.getElementById("fileElem"),
    preview = document.getElementById("preview")

fileElem.addEventListener("change", function(e) {
  console.log(e)
  handleFiles(e.target.files)
}, false);

fileSelect.addEventListener("click", function (e) {
  if (fileElem) {
    fileElem.click();
  }
  e.preventDefault(); // prevent navigation to "#"
}, false);

function handleFiles(files) {
  console.log(files)
  for (var i = 0; i < files.length; i++) {
    var file = files[i];
    var imageType = /^image\//;
    
    if (!imageType.test(file.type)) {
      continue;
    }

    Edit(file)
  }
}

function sendFile(file) {
  var csrf = document.querySelector("meta[name=csrf]").content;
  var uri = "/upload";
  var xhr = new XMLHttpRequest();
  var fd = new FormData();
  xhr.open("POST", uri, true);
  xhr.setRequestHeader("X-CSRF-TOKEN", csrf)

  xhr.upload.addEventListener("progress", function(e) {
    if (e.lengthComputable) {
      var percentage = Math.round((e.loaded * 100) / e.total);
      console.log(percentage)
    }
  }, false);

  xhr.onreadystatechange = function() {
      if (xhr.readyState == 4 && xhr.status == 200) {
          // Handle response.
          alert(xhr.responseText); // handle response.
      }
  };

  fd.append("_csrf_token", csrf);
  fd.append('myFile', file);

  // Initiate a multipart/form-data upload
  xhr.send(fd);
}

