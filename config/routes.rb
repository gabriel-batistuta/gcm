Rails.application.routes.draw do
  root "home#index"

  # Sessões (login/logout)
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Cadastro de usuários (pode ser usado pelo admin ou uma área de auto-cadastro)
  get  '/signup', to: 'users#new'
  post '/users',  to: 'users#create'

  # Rota para troca de senha no primeiro acesso
  get   '/edit_password',   to: 'users#edit_password'
  patch '/update_password', to: 'users#update_password'

  # Recuperação de senha
  get  '/password_reset', to: 'password_resets#new'
  post '/password_reset', to: 'password_resets#create'

  # Área administrativa (exemplo)
  namespace :admin do
    resources :dashboard, only: [:index]
  end
end
