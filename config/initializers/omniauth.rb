Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.google_client_id, Rails.application.secrets.google_client_secret,
    {
      name: 'google',
      client_options: {
        ssl: {
          verify: Garden.config.devise_verify_ssl_certificates
        }
      }
    }
end
