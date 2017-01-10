Rails.application.routes.draw do
  root "users#index"

  resources :users do
    resources :appointments
    get "d_1_t_1" => "appointments"
    get "d_1_t_2" => "appointments"
    get "d_1_t_3" => "appointments"
    get "d_1_t_4" => "appointments"
    get "d_1_t_5" => "appointments"

    get "d_2_t_1" => "appointments"
    get "d_2_t_2" => "appointments"
    get "d_2_t_3" => "appointments"
    get "d_2_t_4" => "appointments"
    get "d_2_t_5" => "appointments"
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
