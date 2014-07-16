$(document).ready(function(){
  wiser_timezone_reload();
  $(window).resize()
});

$(window).resize(function(){
  if($('#wiser_timezone_container').is(':visible')){
    $('html').css('margin-top', $('#wiser_timezone_container').height() + 'px')
  }
})

$(document).on("click", "#wiser_timezone_close", function(){
  $('#wiser_timezone_container').remove()
  $('html').css('margin-top', '0px')
})

var wiser_timezone_reload = function(){
  if($('#wiser_timezone_container').size() > 0){
    if($('#wiser_timezone_container').data('offset-cookie') == 'skip'){
      $('#wiser_timezone_container').remove()
    }else{
      browser_offset = (-(new Date()).getTimezoneOffset() / 60).toString();
      setting_offset = $('#wiser_timezone_space').data('offset')

      if(browser_offset != setting_offset){
        $(window).resize()
        set_url = $('#wiser_timezone_link').attr('href')
        if(!$('#wiser_timezone_link').hasClass('wiser_timezone_link')){
          $('#wiser_timezone_link').addClass('wiser_timezone_link')
          $('#wiser_timezone_link').attr('href', set_url + '?offset=' + encodeURIComponent(browser_offset))
          hours_offset = (new Date()).getTimezoneOffset() / -60
          $('#wiser_timezone_space').html($('#wiser_timezone_space').html().replace('~TZ~','GMT+' + hours_offset))
        }
        close_url = $('#wiser_timezone_close').attr('href')
        $('#wiser_timezone_close').attr('href', close_url + '?offset=skip')
        $('#wiser_timezone_container').show()
      }else{
        $('#wiser_timezone_container').remove()
      }
    }
  }
}