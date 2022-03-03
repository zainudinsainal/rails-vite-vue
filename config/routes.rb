Rails.application.routes.draw do

  # Sidekiq UI
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api, :defaults => { :format => 'json' } do
    resources :products
  end

  root to: 'pages#index'
  match "*path", to: "pages#index", format: false, via: :get
end
