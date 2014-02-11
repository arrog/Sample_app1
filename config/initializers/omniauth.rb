Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "433403447315-p7gnka3viph8km7o0ifptbjmlhio0o2i.apps.googleusercontent.com", "433403447315-p7gnka3viph8km7o0ifptbjmlhio0o2i@developer.gserviceaccount.com"
end