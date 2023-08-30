window.onload = function () {
  const postForm = document.getElementById('post_form');
  const postSubmit = document.querySelector('.btn.btn-warning.btn-lg');
  const postTitle = document.getElementById('post_title');
  const postContent = document.getElementById('post_content');
  const validationMessages = document.getElementById('validation-messages');

  function validateForm(event) {
    let valid = true;
    let messages = [];

    if (postTitle.value.trim() === "") {
      valid = false;
      messages.push("タイトルは必須です");
    }

    if (postContent.value.trim() === "") {
      valid = false;
      messages.push("コンテンツは必須です");
    }

    validationMessages.innerHTML = '';
    messages.forEach(message => {
      const errorElement = document.createElement('div');
      errorElement.className = 'alert alert-danger';
      errorElement.textContent = message;
      validationMessages.appendChild(errorElement);
    });

    if (!valid) {
      event.preventDefault();
    }
  }

  postForm.addEventListener('submit', validateForm);
};
