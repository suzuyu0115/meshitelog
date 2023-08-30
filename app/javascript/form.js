document.addEventListener('turbo:load', function () {
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
      messages.push("飯名は必須です");
    }

    if (postContent.value.trim() === "") {
      valid = false;
      messages.push("コメントは必須です");
    }

    validationMessages.innerHTML = '';
    messages.forEach(message => {
      const errorElement = document.createElement('div');
      errorElement.className = 'alert alert-danger';
      errorElement.textContent = message;
      validationMessages.appendChild(errorElement);
    });

    postSubmit.disabled = !valid;

    if (event && event.type === 'submit' && !valid) {
      event.preventDefault();
    }
  }

  // blurとchangeイベントでバリデーションを実行
  postTitle.addEventListener('blur', validateForm);
  postContent.addEventListener('blur', validateForm);
  postFoodImage.addEventListener('change', validateForm);

  postForm.addEventListener('submit', validateForm);

  // 初回読み込み時のバリデーションチェック
  validateForm();
});
