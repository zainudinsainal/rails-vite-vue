Rails.application.routes.draw do
  devise_for :users

  # APIs
  namespace :api, defaults: { format: 'json' } do
    resources :products
  end

  # Users
  get '/app', to: "users#index"
  match "app/*path", to: "users#index", format: false, via: :get

  # CMS
  # get '/cms', to: "cms#index"
  # match "cms/*path", to: "cms#index", format: false, via: :get

  # Public
  match "*path", to: "public#index", format: false, via: :get
  root to: 'public#index'
end
