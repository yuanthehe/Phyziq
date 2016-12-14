Rails.application.config.sorcery.submodules = [:external]

Rails.application.config.sorcery.configure do |config|
 config.external_providers = [:google]
 config.google.key = "#{Rails.application.secrets.sorcery_google_key}"
 config.google.secret = "#{Rails.application.secrets.sorcery_google_secret}"
 config.google.callback_url = "#{Rails.application.secrets.sorcery_google_callback_url}"
 config.google.user_info_mapping = {:email => "email", :name => "name"}
 config.google.scope = "https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/calendar.readonly"
  # -- core --
  # What controller action to call for non-authenticated users. You can also
  # override the 'not_authenticated' method of course.
  # Default: `:not_authenticated`
  #
  # config.not_authenticated_action =

  config.user_config do |user|

    user.authentications_class = Authentication
  end

  config.user_class = "User"
end
