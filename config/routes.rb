# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: '/account', controllers: {
    confirmations: 'confirmations'
  }

  devise_scope :user do
    get '/account/sign_out' => 'devise/sessions#destroy'
  end

  scope '(:locale)', locale: /en|uk/ do
    resources :users, :home
  end

  root 'home#index'
end
