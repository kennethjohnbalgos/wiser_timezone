module WiserTimezone
  class WiserTimezoneController < ApplicationController
    def set_timezone
      if params[:offset].present?
        if params[:offset] == "skip"
          cookies[:wiser_timezone_offset] = params[:offset]
        elsif params[:offset] == "reset"
          cookies[:wiser_timezone_offset] = nil
        else
          if current_user.present?
            cookies[:wiser_timezone_offset] = nil
            begin
              current_user.update_attribute(:timezone, params[:offset])
            rescue
              raise "You probably need to run the migration. Please review the documentation."
            end
          else
            cookies[:wiser_timezone_offset] = params[:offset]
          end
        end
      end
      begin
        redirect_to :back
      rescue
        redirect_to root_path
      end
    end
  end
end