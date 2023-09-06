Rails.application.routes.draw do
  match '/500', to: 'application#internal_server_error', via: :all
  root 'pages#home'
  get  'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy'
  get  'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'
  get  '/auth/failure',            to: 'sessions/omniauth#failure'
  get  '/auth/:provider/callback', to: 'sessions/omniauth#create'
  post '/auth/:provider/callback', to: 'sessions/omniauth#create'
  resources :pages, only: %i[index create edit update destroy]
  resources :sessions, only: %i[index show destroy]
  resource  :password, only: %i[edit update]
  resource :account, controller: 'account/details', only: %i[show update destroy]
  namespace :account do
    resource :email, only: %i[edit update]
    resource :email_verification, only: %i[show create]
    resource :password_reset, only: %i[new edit create update]
    resource :about, controller: 'details', only: %i[edit]
    resource :address, controller: 'details', only: %i[edit]
  end
  match '*path', to: 'pages#show', via: %i[get post]
end
