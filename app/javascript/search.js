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
