Rails.application.routes.draw do
  root "users#index"

  resources :users
  # resources :appointments
  # resources :appointments, controller: 'appointments/day_1', only: [:show]
  # resources :appointments, controller: 'appointments/day_2', only: [:show]
  # resources :appointments, controller: 'appointments/day_3', only: [:show]
  # resources :appointments, controller: 'appointments/day_4', only: [:show]
  # resources :appointments, controller: 'appointments/day_5', only: [:show]
  # resources :appointments, controller: 'appointments/day_6', only: [:show]
  # resources :appointments, controller: 'appointments/day_7', only: [:show]
  resources :user_sessions, only: [:new, :create, :destroy]

  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout

  post "oauth2callback" => "oauths#callback"
  get "oauth2callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  delete "oauth/:provider" => "oauths#destroy", :as => :delete_oauth

  get "day_1" => "appointments", :as => :day_1
  get "day_2" => "appointments", :as => :day_2
  get "day_3" => "appointments", :as => :day_3
  get "day_4" => "appointments", :as => :day_4
  get "day_5" => "appointments", :as => :day_5
  get "day_6" => "appointments", :as => :day_6
  get "day_7" => "appointments", :as => :day_7
end
