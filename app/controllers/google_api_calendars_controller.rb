class GoogleApiCalendarsController < ApplicationController
  before_action :require_login

  #Obtain an authorization code
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

  #Obtain an access token
  def callback
    client = Signet::OAuth2::Client.new({
      client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      redirect_uri: url_for(:action => :callback),
      code: params[:code]
    })
    response = client.fetch_access_token!
    session[:access_token] = response['access_token']
    redirect_to url_for(:action => :calendars)
  end

  # Call the Google Calendar API
  def calendars
    client = Signet::OAuth2::Client.new(access_token: session[:access_token])
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    @calendar_list = service.list_calendar_lists
  end
