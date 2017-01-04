Rails.application.routes.draw do
  root "users#index"

  resources :users
  resources :appointments
  resources :user_sessions, only: [:new, :create, :destroy]

  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout

  post "oauth2callback" => "oauths#callback"
  get "oauth2callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  delete "oauth/:provider" => "oauths#destroy", :as => :delete_oauth

  get "day_1" => "#{:appointment_id}/day_1", :as => :day_1
  get "day_2" => "#{:appointment_id}/day_2", :as => :day_2
  get "day_3" => "#{:appointment_id}/day_3", :as => :day_3
  get "day_4" => "#{:appointment_id}/day_4", :as => :day_4
  get "day_5" => "#{:appointment_id}/day_5", :as => :day_5
  get "day_6" => "#{:appointment_id}/day_6", :as => :day_6
  get "day_7" => "#{:appointment_id}/day_7", :as => :day_7

end
