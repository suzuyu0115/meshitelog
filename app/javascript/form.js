document.addEventListener('turbo:load', function () {
  const postForm = document.getElementById('post_form');
  const postSubmit = document.querySelector('.btn.btn-warning.btn-lg');
  const postTitle = document.getElementById('post_title');
  const postContent = document.getElementById('post_content');

  function validateForm(event) {
    let valid = true;

    if (postTitle.value.trim() === "") {
      valid = false;

      // ユーザーがフィールドに何かを入力してからのみスタイルを適用
      if (event && event.type === 'blur') {
        postTitle.classList.add('is-invalid');
      }
      postTitle.classList.remove('is-valid');
    } else {
      postTitle.classList.add('is-valid');
      postTitle.classList.remove('is-invalid');
    }

    if (postContent.value.trim() === "") {
      valid = false;

      // ユーザーがフィールドに何かを入力してからのみスタイルを適用
      if (event && event.type === 'blur') {
        postContent.classList.add('is-invalid');
      }
      postContent.classList.remove('is-valid');
    } else {
      postContent.classList.add('is-valid');
      postContent.classList.remove('is-invalid');
    }

    postSubmit.disabled = !valid;

    if (event && event.type === 'submit' && !valid) {
      event.preventDefault();
    }
  }

  postTitle.addEventListener('blur', validateForm);
  postContent.addEventListener('blur', validateForm);

  postForm.addEventListener('submit', validateForm);

  // 初回読み込み時のバリデーションチェック
  validateForm();
});
