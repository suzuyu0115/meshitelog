$(document).on('input', '#q_title_cont', function () {
  let query = $(this).val();

  $.ajax({
    url: '/posts',
    data: {
      q: {
        title_cont: query
      }
    },
    type: 'GET',
    dataType: 'html',
    success: function (data) {
      $('.row .col-12 .row').first().html(data);
    }
  });
});

// タグのインクリメンタルサーチ
$(document).on('input', '#q_tag_name_cont', function () {
  let query = $(this).val();

  if (query.length >= 1) {
    $.ajax({
      url: '/posts/search_tags',
      data: { query: query },
      type: 'GET',
      dataType: 'json',
      success: function (data) {
        // 既存のドロップダウンリストをクリア
        $('.tag-dropdown').remove();

        // 新しいドロップダウンリストを作成
        let dropdown = $('<ul class="tag-dropdown list-group">');
        data.forEach(function (tag) {
          let tagItem = $('<li class="list-group-item">').text(tag);
          dropdown.append(tagItem);
        });

        // 入力フィールドの下にドロップダウンリストを表示
        $('#q_tag_name_cont').after(dropdown);
      }
    });
  } else {
    // クエリが短すぎるか、空の場合はドロップダウンを削除
    $('.tag-dropdown').remove();
  }
});

// ドロップダウンのタグをクリックした場合、入力フィールドにそのタグを設定
$(document).on('click', '.tag-dropdown li', function () {
  let tag = $(this).text();
  $('#q_tag_name_cont').val(tag);
  $('.tag-dropdown').remove();
});
