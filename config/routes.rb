Rails.application.routes.draw do
  devise_for :users

  # APIs
  namespace :api, defaults: { format: 'json' } do
    resources :products
  end

  # Users
  constraints subdomain: 'app' do
    get '/', to: "users#index"
    match "*path", to: "users#index", format: false, via: :get
  end

  # CMS
  # constraints subdomain: 'cms' do
    # get '/', to: "cms#index"
    # match "cms/*path", to: "cms#index", format: false, via: :get
  # end

  # Public
  constraints subdomain: '' do
    get '/', to: "public#index"
    match "*path", to: "public#index", format: false, via: :get
  end
  root to: 'public#index'
end
