Rails.application.config.sorcery.submodules = [:external]

Rails.application.config.sorcery.configure do |config|
<<<<<<< HEAD
  ...
  config.external_providers = [:google]
=======
 config.external_providers = [:google]
 config.google.key = "#{Rails.application.secrets.sorcery_google_key}"
 config.google.secret = "#{Rails.application.secrets.sorcery_google_secret}"
 config.google.callback_url = "#{Rails.application.secrets.sorcery_google_callback_url}"
 config.google.user_info_mapping = {:email => "email", :name => "name"}
 config.google.scope = "https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/calendar"
  # -- core --
  # What controller action to call for non-authenticated users. You can also
  # override the 'not_authenticated' method of course.
  # Default: `:not_authenticated`
  #
  # config.not_authenticated_action =
>>>>>>> c6d30b9480d48a5b7a9358614342c0198acf7b81

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
