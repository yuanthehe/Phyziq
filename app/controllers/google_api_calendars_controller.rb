class GoogleApiCalendarsController < ApplicationController
  before_action :require_login

  def redirect
    client = Signet::OAuth2::Client.new({
      client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
      redirect_uri: url_for(:action => :callback)
    })
    redirect_to client.authorization_uri.to_s
  end

  def callback
  end

  def calendars
  end
end
