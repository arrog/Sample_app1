OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "200803726740237", "df514a9073bd117a31338bf26d92b8a0"
end