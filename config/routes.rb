Rails.application.routes.draw do
  namespace :api, :defaults => { :format => 'json' } do
    resources :products do
      patch :upload, on: :member
    end
  end

  get 'admin/home', to: 'admin/home#index'

  root to: 'pages#index'
  match "*path", to: "pages#index", format: false, via: :get
end
