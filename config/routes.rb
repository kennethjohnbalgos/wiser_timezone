Rails.application.routes.draw do
  get 'set_timezone' => 'wiser_timezone/wiser_timezone#set_timezone', :as => 'set_timezone'
end