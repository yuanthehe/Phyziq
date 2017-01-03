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

  get "day_1" => "user#day_1"
  get "day_2" => "user#day_2"
  get "day_3" => "user#day_3"
  get "day_4" => "user#day_4"
  get "day_5" => "user#day_5"
  get "day_6" => "user#day_6"
  get "day_7" => "user#day_7"

end
