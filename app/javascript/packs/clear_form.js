document.addEventListener("turbo:submit-end", function(event) {
  if (event.target.matches('form[data-remote="true"]')) {
    event.target.reset();
  }
});