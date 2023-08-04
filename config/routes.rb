Rails.application.routes.draw do
  get "/#{I18n.default_locale}", to: redirect('/')
  get "/#{I18n.default_locale}/*path", to: redirect('/%{path}')

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    root 'home#index'

    devise_scope :user do
      get '(/:locale)/account/sign_out' => 'devise/sessions#destroy'
    end

    devise_for :users, path: '/account', controllers: {
      confirmations: 'confirmations'
    }
  end
end
