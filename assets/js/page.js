function copyContent() {
  document.getElementById("hiddenTextarea").value =
    document.getElementById("blockContentEditable").innerText;
  return true;
}

document.addEventListener('ajax:success', function(e) {
  if(e.target && e.target.hasAttribute('ujs-remote')) {
    var block = JSON.parse(e.data.xhr.responseText);
    document.getElementById("blockContentEditable").innerHTML = block.text;
  }
});

$(document).ready(function() {
  $("#block_form").submit(function(event) {
    copyContent(document.getElementById("hiddenTextarea").value);
  });
});
