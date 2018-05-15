$(function() {
  if ($('#infinite-scrolling').size() > 0){
    $('.panel-body').on('scroll', function() {
      var scroll = $('.panel-body').scrollTop();
      if (scroll <= 0){
        var next_page_url = $('.pagination .next a').attr("href");
        if (next_page_url)
        {
          $('#infinite-scrolling').removeClass('hide')
          $('.pagination').html('<img src="/assets/loader.gif" alt="Loading..." title="Loading..." />');
          $.getScript (next_page_url)
        }
      }
    });
  }

  $('.panel-body').scrollTop($('.panel-body').prop("scrollHeight"))

});
