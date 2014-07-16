module WiserTimezone
  module WiserTimezoneHelper

    def ensure_timezone
      Time.zone = current_timezone
    end

    def current_timezone
      return ActiveSupport::TimeZone[offset.to_i]
    end

    def current_timezone_slim
      location = current_timezone.to_s.split(" ").last()
      offset = current_timezone_offset
      return "(#{offset}) #{location}"
    end

    def current_timezone_location
      return current_timezone.to_s.split(" ").last()
    end

    def current_timezone_offset
      timezone_str = current_timezone.to_s
      offset_str = timezone_str[timezone_str.index('(')+1..-1].split(':').first()
      return "#{offset_str[0..3]}#{offset_str[4..-1].to_i}"
    end

    def current_timezone_offset_slim
      current_timezone_offset[3..-1]
    end

    def wiser_timezone(date, date_only = false)
      begin
        date_time = date.to_datetime
        if date_only
          return date_time.in_time_zone(current_timezone).beginning_of_day
        else
          return date_time.in_time_zone(current_timezone)
        end
      rescue
        raise "WiserTimezone can only accept date object."
      end
    end

    def wt(date, date_only = false)
      wiser_timezone(date, date_only)
    end

    def wiser_timezone_initialize
      set_link = link_to('click here', set_timezone_path, :id => 'wiser_timezone_link')
      close_link = link_to('skip', set_timezone_path(offset: 'skip'), :id => 'wiser_timezone_close', :remote => true)
      if offset.present?
        msg = "Your computer's timezone does not appear to match your current setting #{current_timezone_slim}, <span class='no_wrap'>#{set_link} to update the timezone to ~TZ~.</span> Otherwise, #{close_link} setting your timezone."
      else
        msg = "You do not have timezone in your settings, <span class='no_wrap'>#{set_link} to update the timezone to ~TZ~.</span> Otherwise, #{close_link} setting your timezone."
      end
      space = "<div id='wiser_timezone_space' data-offset='#{offset}'>#{msg}</div>"
      html = "<div id='wiser_timezone_container' style='display:none;' data-offset-cookie='#{cookies[:wiser_timezone_offset]}'>#{space}</div>"
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