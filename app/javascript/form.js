window.onload = function () {
  const postSubmit = document.querySelector('.btn.btn-warning.btn-lg');
  const postTitle = document.getElementById('post_title');
  const postContent = document.getElementById('post_content');
  const validationMessages = document.getElementById('validation-messages');

  function validateForm() {
    let valid = true;
    let messages = [];

    // タイトルのバリデーション
    if (postTitle.value.trim() === "") {
      valid = false;
      messages.push("タイトルは必須です");
    }

    // コンテンツのバリデーション
    if (postContent.value.trim() === "") {
      valid = false;
      messages.push("コンテンツは必須です");
    }

    validationMessages.innerHTML = messages.join('<br>');
    postSubmit.disabled = !valid;
  }

  postTitle.addEventListener('blur', validateForm);
  postContent.addEventListener('blur', validateForm);
  postFoodImage.addEventListener('change', validateForm);

  // 初期のチェック
  validateForm();
};
