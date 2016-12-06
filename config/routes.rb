Rails.application.routes.draw do

  get 'users/index'

  get 'users/new'

  get 'users/show'

  get 'users/edit'

  resources :users
  resources :appointments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
