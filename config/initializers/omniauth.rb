Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
end
OmniAuth.config.allowed_request_methods = %i[get]
OmniAuth.config.silence_get_warning = true

