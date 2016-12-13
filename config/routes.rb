Rails.application.routes.draw do

  root "users#index"

  resources :users
  resources :appointments
  resources :user_sessions, only: [:new, :create, :destroy]

  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout


  post "oauth2callback" => "oauths#callback"
  get "oauth2callback" => "oauths#callback" # for use with Github
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  delete "oauth/:provider" => "oauths#destroy", :as => :delete_oauth

  # get "https://www.googleapis.com/calendar/v3/calendars/calendarId/events"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
