class AppointmentsController < ApplicationController
  before_action :require_login

  def oauth

  end

  def new
    # client = Signet::OAuth2::Client.new({
    # client_id: "#{Rails.application.secrets.sorcery_google_key}",
    # client_secret: "#{Rails.application.secrets.sorcery_google_secret}",
    # token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
    # access_token: session[:access_token]
    # })
    # client.expires_in = Time.now + 1_000_000
    # service = Google::Apis::CalendarV3::CalendarService.new
    # service.authorization = client
    #
    # event = Google::Apis::CalendarV3::Event.new({
    #   'summary':'Testing',
    #   'location':'Bitmaker',
    #   'description':'Testing insert event',
    #   'start':{
    #     'date_time': DateTime.parse('2017-01-09T09:00:00-07:00'),
    #   },
    #   'end':{
    #     'date_time': DateTime.parse('2017-01-09T17:00:00-07:00'),
    #   }
    # })
    #
    # testing = service.insert_event('primary', event)
    # "Event created: #{testing.html_link}"
  end

  def show

  end

  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      @appointment.trainee_id = @user.id
      redirect_to user_url(@appointment.trainee), notice: "Appointment request sent!"
    else
      flash[:alert] = "Failed to process appointment request"
      render '/users'
    end

  end

  def index
    if @user.trainer_appointments != nil
      @user.trainer_appointments
    else
      @user.trainee_appointments
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def d_1_t_1
    generic_google_authentication

    t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    t_2 = Time.parse("15:30").seconds_since_midnight.seconds

    upper_i = (day + t_1).to_i
    lower_i = (day + t_2).to_i

    upper = Time.at(upper_i)
    lower = Time.at(lower_i)

    day = Date.today + 1

    event = Google::Apis::CalendarV3::Event.new({
      'summary':'Testing',
      'location':'Bitmaker',
      'description':'Testing insert event',
      'start':{
        'date_time': DateTime.parse("#{upper}"),
      },
      'end':{
        'date_time': DateTime.parse("#{lower}"),
      'attendees':[{
        'email':"#{@user.email}"}
      ]
      }
    })

    appt = service.insert_event('primary', event)
    "Event created: #{testing.html_link}"
  end

private

  def load_appointment
    #load appointment by trainer/trainee
  end

  def appointment_params
    params.require(:appointment).permit(:event, :event_start_time, :event_end_time, :event_invitation_status, :trainer_id, :trainee_id, :created_at, :updated_at)
  end

  def generic_google_authentication
    client = Signet::OAuth2::Client.new({
    # grant_type: "refresh_token",
    client_id: "#{Rails.application.secrets.sorcery_google_key}",
    client_secret: "#{Rails.application.secrets.sorcery_google_secret}",
    token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
    access_token: session[:access_token]
    })
    client.expires_in = Time.now + 1_000_000
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
  end

  def event_list_google_authentication
    client = Signet::OAuth2::Client.new({
    # grant_type: "refresh_token",
    client_id: "#{Rails.application.secrets.sorcery_google_key}",
    client_secret: "#{Rails.application.secrets.sorcery_google_secret}",
    token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
    access_token: session[:access_token]
    })
    client.expires_in = Time.now + 1_000_000
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    result = service.list_events('primary')

    @start_time = result.items.map {|e|
      if e.start.date_time != nil
         e.start.date_time.to_i
      else
         next
      end
    }.compact

    @end_time = result.items.map {|e|
      if e.end.date_time != nil
         e.end.date_time.to_i
      else
         next
      end
    }.compact
  end
end
