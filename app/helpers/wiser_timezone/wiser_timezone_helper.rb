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

    def wiser_timezone_initialize(options = {})
      force = options[:force].present? && options[:force]
      if auto_set_all = options[:auto_set_all].present? && options[:auto_set_all]
        auto_set_all = true
      else
        auto_set_all = false
        auto_set_guest = options[:auto_set_guest].present? && options[:auto_set_guest]
      end

      set_link = link_to('click here', set_timezone_path, :id => 'wiser_timezone_link')
      close_link = link_to('skip', set_timezone_path(offset: 'skip'), :id => 'wiser_timezone_close', :remote => true)

      if offset.present?
        msg = "Your system's timezone does not match your current setting #{current_timezone_slim}, <span class='no_wrap'>#{set_link}</span> to update the timezone to ~TZ~.#{'<br/>' if force}Otherwise, #{close_link} setting your timezone."
      else
        msg = "You do not have timezone in your settings, <span class='no_wrap'>#{set_link}</span> to update the timezone to ~TZ~.#{'<br/>' if force}Otherwise, #{close_link} setting your timezone."
      end
      classes = "#{'force' if force} #{'no_user' if auto_set_guest} #{'auto_set' if auto_set_all}"
      space = "<div id='wiser_timezone_space' data-offset='#{offset}'>#{msg}</div>"
      cover = "<div id='wiser_timezone_cover'></div>"
      html = "<div id='wiser_timezone_container' class='#{classes}' style='display:none;' data-offset-cookie='#{cookies[:wiser_timezone_offset]}'>#{cover} #{space}</div>"
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
        if cookies[:wiser_timezone_offset] == 'clear'
          cookies[:wiser_timezone_offset] = nil
        else
          @timezone_offset ||= cookies[:wiser_timezone_offset]
        end
      end
      return @timezone_offset
    end
  end
end