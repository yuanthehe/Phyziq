Rails.application.config.sorcery.submodules = [:external]

Rails.application.config.sorcery.configure do |config|
  ...
  config.external_providers = [:google]

# add this file to .gitignore BEFORE putting any secret keys in here

  config.google.key = "969431139863-eleubhdaicasbt6m4vjovq3ot8e906pc.apps.googleusercontent.com"
  config.google.secret = "rHJYGKcabfVEqKbkW6j_hUo9"
  config.google.callback_url = "http://0.0.0.0:3000/oauth/callback?provider=google"
  config.google.user_info_mapping = {
    :email => "email",
    :first_name => "given_name",
    :last_name => "family_name"
  }

  …

  config.user_config do |user|
  ...

    user.authentications_class = Authentication
    ...

  end
  ...
  config.user_class = "User"
end
