let previousRequest;

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

$(document).on('input', '#q_tag_name_cont', function () {
  let query = $(this).val();

  if (previousRequest) {
    previousRequest.abort();
  }

  if (query.length >= 1) {
    previousRequest = $.ajax({
      url: '/posts/search_tags',
      data: { query: query },
      type: 'GET',
      dataType: 'json',
      success: function (data) {
        $('.tag-dropdown').remove();

        let dropdown = $('<ul class="tag-dropdown list-group">');
        data.forEach(function (tag) {
          let tagItem = $('<li class="list-group-item">').text(tag);
          dropdown.append(tagItem);
        });

        $('#q_tag_name_cont').after(dropdown);
      },
      complete: function () {
        previousRequest = null;
      }
    });
  } else {
    $('.tag-dropdown').remove();
  }

  if (!query) {
    $('.tag-dropdown').hide();
    return;
  }
});

$(document).on('click', '.tag-dropdown li', function () {
  let tag = $(this).text();
  $('#q_tag_name_cont').val(tag);
  $('.tag-dropdown').remove();
});

$(document).on('blur', '#q_tag_name_cont', function () {
  setTimeout(function () {
    $('.tag-dropdown').remove();
  }, 100);
});
