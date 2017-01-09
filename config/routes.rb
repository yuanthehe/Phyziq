Rails.application.routes.draw do
  root "users#index"

  resources :users do
    resources :appointments
    get "d_1_t_1" => "appointments", :as => :d_1_t_1
    get "d_1_t_2" => "appointments", :as => :d_1_t_2
    get "d_1_t_3" => "appointments", :as => :d_1_t_3
    get "d_1_t_4" => "appointments", :as => :d_1_t_4
    get "d_1_t_5" => "appointments", :as => :d_1_t_5
  end
  resources :user_sessions, only: [:new, :create, :destroy]

  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout

  post "oauth2callback" => "oauths#callback"
  get "oauth2callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  delete "oauth/:provider" => "oauths#destroy", :as => :delete_oauth

  get "weekly_hourly" => "availabilities", :as => :refresh_availability

end
