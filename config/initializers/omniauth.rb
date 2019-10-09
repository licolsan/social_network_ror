Rails.application.config.middleware.use OmniAuth::Builder do
  env = Rails.application.credentials.env

  provider :facebook, env[:facebook_client_id], env[:facebook_client_secret]
  provider :google_oauth2, env[:google_client_id], env[:google_client_secret]
end
