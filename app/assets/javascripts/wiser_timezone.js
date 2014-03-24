$(document).ready(function(){
  wiser_timezone_reload();

  $(window).resize(function(){
    if($('#wiser_timezone_container').is(':visible')){
      $('body').css('margin-top', $('#wiser_timezone_container').height() + 'px')
    }
  })
});

var wiser_timezone_reload = function(){
  if($('#wiser_timezone_container').is(':visible')){
    browser_offset = (-(new Date()).getTimezoneOffset() / 60).toString();
    setting_offset = $('#wiser_timezone_space').data('offset')

    if(browser_offset != setting_offset){
      $(window).resize()
      url = $('#wiser_timezone_link').attr('href')
      if(!$('#wiser_timezone_link').hasClass('wiser_timezone_link')){
        $('#wiser_timezone_link').addClass('wiser_timezone_link')
        $('#wiser_timezone_link').attr('href', url + '?offset=' + encodeURIComponent(browser_offset))
        hours_offset = (new Date()).getTimezoneOffset() / -60
        $('#wiser_timezone_space').html($('#wiser_timezone_space').html().replace('~TZ~','GMT+' + hours_offset))
      }
    }else{
      $('#wiser_timezone_container').remove()
    }
  }
}