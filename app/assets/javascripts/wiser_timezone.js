$(document).ready(function(){
  wiser_timezone_reload();
});

var wiser_timezone_reload = function(){
  if($('#wiser_timezone_container').is(':visible')){
    browser_offset = (-(new Date()).getTimezoneOffset() / 60).toString();
    setting_offset = $('#wiser_timezone_space').data('offset')


    if(browser_offset != setting_offset){
      $('body').css('margin-top', '50px')
      $('#wiser_timezone_container').show()
      url = $('#wiser_timezone_link').attr('href')
      $('#wiser_timezone_link').attr('href', url + '?offset=' + encodeURIComponent(browser_offset))
    }else{
      $('#wiser_timezone_container').remove()
    }
  }
}