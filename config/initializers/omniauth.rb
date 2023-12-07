Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           Rails.application.credentials.oauth2[:client_id],
           Rails.application.credentials.oauth2[:client_secret]
end
OmniAuth.config.allowed_request_methods = %i[get]
OmniAuth.config.silence_get_warning = true

