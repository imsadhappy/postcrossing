
Rails.application.routes.draw do
  root 'home#index'

  get '/:locale' => 'home#index'

  devise_scope :user do
    get '(/:locale)/account/sign_out' => 'devise/sessions#destroy'
  end

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    devise_for :users, path: '/account', controllers: {
      confirmations: 'confirmations'
    }
  end
end
