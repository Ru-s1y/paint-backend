if Rails.env = "production"
  Rails.application.config.session_store :cookie_store,
    key: "_Myapp", domain: "imitless-sands-71522.herokuapp.com",
    secure: Rails.env.production?
else
  Rails.application.config.session_store :cookie_store, key: "_Myapp"
end