module WiserTimezone
  class WiserTimezoneController < ApplicationController
    def set_timezone
      if params[:offset].present?
        if current_user.present?
          current_user.update_attribute(:timezone, params[:offset])
        else
          cookies[:wiser_timezone_offset] = params[:offset]
        end
      end
      redirect_to :back
    end
  end
end