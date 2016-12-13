Rails.application.routes.draw do

  root "users#index"

  resources :users
  resources :appointments
  resources :user_sessions, only: [:new, :create, :destroy]

  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout


  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  delete "oauth/:provider" => "oauths#destroy", :as => :delete_oauth
  # get "oauth/:redirect" => "oauth#redirect", :as => :redirect_oauth
  # get "oauth/:oauth2callback" => "oauth#ouath2callback", :as => :oauth_oauth2callback
  # root 'todos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
