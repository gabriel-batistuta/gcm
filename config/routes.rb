Rails.application.routes.draw do
  get "home/index"
  root "home#index"

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :dashboard, only: [:index]
  end  
  # Outras rotas...
end
