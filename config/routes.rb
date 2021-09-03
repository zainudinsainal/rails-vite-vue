Rails.application.routes.draw do
  devise_for :users

  # APIs
  namespace :api, defaults: { format: 'json' } do
    resources :products
  end

  # Admin
  get '/adm', to: "admins#index"
  match "adm/*path", to: "admins#index", format: false, via: :get

  # Employee
  # get '/emp', to: "employees#index"
  # match "emp/*path", to: "employees#index", format: false, via: :get

  # Public
  match "*path", to: "public#index", format: false, via: :get
  root to: 'public#index'
end
