Rails.application.routes.draw do
  root "users#index"

  resources :users do
    resources :appointments, only: [:update, :show, :destroy, :index, :edit]
    get "d_1_t_1" => "appointments"
    get "d_1_t_2" => "appointments"
    get "d_1_t_3" => "appointments"
    get "d_1_t_4" => "appointments"
    get "d_1_t_5" => "appointments"
    get "d_1_t_6" => "appointments"

    get "d_2_t_1" => "appointments"
    get "d_2_t_2" => "appointments"
    get "d_2_t_3" => "appointments"
    get "d_2_t_4" => "appointments"
    get "d_2_t_5" => "appointments"
    get "d_2_t_6" => "appointments"

    get "d_3_t_1" => "appointments"
    get "d_3_t_2" => "appointments"
    get "d_3_t_3" => "appointments"
    get "d_3_t_4" => "appointments"
    get "d_3_t_5" => "appointments"
    get "d_3_t_6" => "appointments"

    get "d_4_t_1" => "appointments"
    get "d_4_t_2" => "appointments"
    get "d_4_t_3" => "appointments"
    get "d_4_t_4" => "appointments"
    get "d_4_t_5" => "appointments"
    get "d_4_t_6" => "appointments"

    get "d_5_t_1" => "appointments"
    get "d_5_t_2" => "appointments"
    get "d_5_t_3" => "appointments"
    get "d_5_t_4" => "appointments"
    get "d_5_t_5" => "appointments"
    get "d_5_t_6" => "appointments"

    get "d_6_t_1" => "appointments"
    get "d_6_t_2" => "appointments"
    get "d_6_t_3" => "appointments"
    get "d_6_t_4" => "appointments"
    get "d_6_t_5" => "appointments"
    get "d_6_t_6" => "appointments"

    get "d_7_t_1" => "appointments"
    get "d_7_t_2" => "appointments"
    get "d_7_t_3" => "appointments"
    get "d_7_t_4" => "appointments"
    get "d_7_t_5" => "appointments"
    get "d_7_t_6" => "appointments"
  end

  resources :users do
    resources :categories, only: [:create, :update, :destroy, :index, :edit]
  end

  resources :user_sessions, only: [:new, :create, :destroy]

  get 'logout' => 'user_sessions#destroy', :as => :logout
  get 'authorization_error' => 'users', :as => :authorization_error

  post "oauth2callback" => "oauths#callback"
  get "oauth2callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  # delete "oauth/:provider" => "oauths#destroy", :as => :delete_oauth

  get "weekly_hourly" => "availabilities", :as => :refresh_availability

end
