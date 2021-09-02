Rails.application.routes.draw do
  devise_for :users
  namespace :api, :defaults => { :format => 'json' } do
    resources :products
  end

  root to: 'pages#index'
  match "*path", to: "pages#index", format: false, via: :get
end
