Rails.application.config.middleware.use OmniAuth::Builder do
  credentials = Rails.application.credentials.config
  provider :developer unless Rails.env.production?
  provider :facebook, credentials[:facebook][:app_id], credentials[:facebook][:app_secret]
  provider :google_oauth2, credentials[:google][:client_id], credentials[:google][:client_secret]
end
