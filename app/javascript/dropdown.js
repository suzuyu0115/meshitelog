document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('[data-stopPropagation]').forEach(function (element) {
    element.addEventListener('click', function (e) {
      e.stopPropagation();
    });
  });
});
