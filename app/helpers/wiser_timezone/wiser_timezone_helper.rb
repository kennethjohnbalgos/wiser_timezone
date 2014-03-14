module WiserTimezone
  module WiserTimezoneHelper

    def current_timezone
      return ActiveSupport::TimeZone[offset.to_i]
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
        msg = "Your computer's timezone does not appear to match the current setting #{current_timezone}. #{link} to update the timezone."
      else
        msg = "You do not have timezone in your user setting. #{link} to save your time zone."
      end
      space = "<div id='wiser_timezone_space' data-offset='#{offset}'>#{msg}</div>"
      html = "<div id='wiser_timezone_container'>#{space}</div>"
      return html.html_safe
    end

    private

    def offset
      if current_user.present? && current_user.try(:timezone).present?
        offset = current_user.timezone
      elsif cookies[:wiser_timezone_offset].present?
        offset = cookies[:wiser_timezone_offset]
      else
        offset = 0
      end
      return offset.to_i
    end
  end
end