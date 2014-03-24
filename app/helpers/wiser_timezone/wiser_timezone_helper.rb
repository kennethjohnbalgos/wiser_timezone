module WiserTimezone
  module WiserTimezoneHelper

    def current_timezone
      return ActiveSupport::TimeZone[offset.to_i]
    end

    def current_timezone_offset
      timezone_str = current_timezone.to_s
      offset_str = timezone_str[timezone_str.index('(')+1..-1].split(':').first()
      return "#{offset_str[0..3]}#{offset_str[4..-1].to_i}"
    end

    def wiser_timezone(date)
      begin
        date_time = date.to_datetime
        return date_time.in_time_zone(current_timezone)
      rescue
        raise "WiserTimezone can only accept date object."
      end
    end

    def wiser_timezone_initialize
      link = link_to('Click Here', set_timezone_path, :method => 'post', :data => {:offset => "#{offset}"}, :id => 'wiser_timezone_link')
      if offset.present?
        msg = "Your computer's timezone does not appear to match the current setting #{current_timezone}. <span class='no_wrap'>#{link} to update the timezone to ~TZ~.</span>"
      else
        msg = "You do not have timezone in your user settings. <span class='no_wrap'>#{link} to set your timezone to ~TZ~.</span>"
      end
      space = "<div id='wiser_timezone_space' data-offset='#{offset}'>#{msg}</div>"
      html = "<div id='wiser_timezone_container' style='display:block;'>#{space}</div>"
      return html.html_safe
    end

    private

    def offset
      if current_user.present?
        if current_user.try(:timezone).present?
          @timezone_offset ||= current_user.timezone
        else
          @timezone_offset = nil
        end
      elsif cookies[:wiser_timezone_offset].present?
        @timezone_offset ||= cookies[:wiser_timezone_offset]
      end
      return @timezone_offset
    end
  end
end