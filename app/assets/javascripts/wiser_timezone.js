$(document).ready(function(){
  if($('#wiser_timezone_container').is(':visible')){
    // Browser
    browser_time = new Date();
    browser_offset = (-browser_time.getTimezoneOffset() / 60).toString();

    // User Settings
    setting_offset = $('#wiser_timezone_space').data('offset')

    if(browser_offset != setting_offset){
      $('body').css('margin-top', '50px')
      url = $('#wiser_timezone_link').attr('href')
      $('#wiser_timezone_link').attr('href', url + '?offset=' + encodeURIComponent(browser_offset))
    }else{
      $('#wiser_timezone_container').hide()
    }
  }

  function zerofill(number, length){
    var str = "" + number
    while(str.length < length){
      str = '0' + str
    }
    return str
  }
});