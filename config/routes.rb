Rails.application.routes.draw do

  root "users#index"

  resources :users
  resources :appointments
  resources :user_sessions, only [:new, :create, :destroy]

  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', as: => :logout
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
