module WiserTimezone
  class WiserTimezoneController < ApplicationController
    def set_timezone
      if params[:offset].present?
        if params[:offset] == "skip"
          cookies[:wiser_timezone_offset] = params[:offset]
        else
          if current_user.present?
            cookies[:wiser_timezone_offset] = nil
            begin
              unless params[:offset] == "reset"
                current_user.update_attribute(:timezone, params[:offset])
              end
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