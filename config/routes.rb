Rails.application.routes.draw do
  root "users#index"

  resources :users
  resources :user_sessions, only: [:new, :create, :destroy]

  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout

  post "oauth2callback" => "oauths#callback"
  get "oauth2callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  delete "oauth/:provider" => "oauths#destroy", :as => :delete_oauth

  get "day_1" => "availabilities", :as => :day_1
  get "day_2" => "availabilities", :as => :day_2
  get "day_3" => "availabilities", :as => :day_3
  get "day_4" => "availabilities", :as => :day_4
  get "day_5" => "availabilities", :as => :day_5
  get "day_6" => "availabilities", :as => :day_6
  get "day_7" => "availabilities", :as => :day_7

  get "weekly_hourly" => "availabilities", :as => :refresh_availability

end
