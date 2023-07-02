Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [:get]
  provider :line, ENV.fetch('LINE_CHANNEL_ID', nil), ENV.fetch('LINE_CHANNEL_SECRET', nil)
end
