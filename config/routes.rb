Rails.application.routes.draw do
  root 'home#index'
  get  'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get  'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'
  get  '/auth/failure',            to: 'sessions/omniauth#failure'
  get  '/auth/:provider/callback', to: 'sessions/omniauth#create'
  post '/auth/:provider/callback', to: 'sessions/omniauth#create'
  resources :sessions, only: %i[index show destroy]
  resource  :password, only: %i[edit update]
  match '/account', to: redirect('/account/detail'), via: %i[get post]
  namespace :account do
    resource :email,              only: %i[edit update]
    resource :email_verification, only: %i[show create]
    resource :password_reset,     only: %i[new edit create update]
    resource :detail,             only: %i[show edit update destroy]
  end
  match '*path', to: redirect('/404.html'), via: %i[get post]
end
