module WiserTimezone
  class WiserTimezoneController < ApplicationController
    def set_timezone
      if params[:offset].present?
        if current_user.present?
          begin
            current_user.update_attribute(:timezone, params[:offset])
          rescue
            raise "You probably need to run the migration. Please review the documentation."
          end
        else
          cookies[:wiser_timezone_offset] = params[:offset]
        end
      end
      redirect_to :back
    end
  end
end