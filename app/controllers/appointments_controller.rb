class AppointmentsController < ApplicationController
  before_action :require_login
  before_action :load_user

  def new
    @appointment = Appointment.new
  end

  def show

  end

  def create
    @appointment = Appointment.new(appointment_params)
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

    @day = Date.today + 1
    @t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_1_t_2
    generic_google_authentication

    @day = Date.today + 1
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_1_t_3
    generic_google_authentication

    @day = Date.today + 1
    @t_1 = Time.parse("17:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("18:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_1_t_4
    generic_google_authentication

    @day = Date.today + 1
    @t_1 = Time.parse("18:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("20:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_1_t_5
    generic_google_authentication

    @day = Date.today + 1
    @t_1 = Time.parse("20:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("21:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_1_t_6
    generic_google_authentication

    @day = Date.today + 1
    @t_1 = Time.parse("21:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("23:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_2_t_1
    generic_google_authentication

    @day = Date.today + 2
    @t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_2_t_2
    generic_google_authentication

    @day = Date.today + 2
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_2_t_3
    generic_google_authentication

    @day = Date.today + 2
    @t_1 = Time.parse("17:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("18:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_2_t_4
    generic_google_authentication

    @day = Date.today + 2
    @t_1 = Time.parse("18:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("20:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_2_t_5
    generic_google_authentication

    @day = Date.today + 2
    @t_1 = Time.parse("20:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("21:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_2_t_6
    generic_google_authentication

    @day = Date.today + 2
    @t_1 = Time.parse("21:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("23:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_3_t_1
    generic_google_authentication

    @day = Date.today + 3
    @t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_3_t_2
    generic_google_authentication

    @day = Date.today + 3
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_3_t_3
    generic_google_authentication

    @day = Date.today + 3
    @t_1 = Time.parse("17:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("18:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_3_t_4
    generic_google_authentication

    @day = Date.today + 3
    @t_1 = Time.parse("18:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("20:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_3_t_5
    generic_google_authentication

    @day = Date.today + 3
    @t_1 = Time.parse("20:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("21:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_3_t_6
    generic_google_authentication

    @day = Date.today + 3
    @t_1 = Time.parse("21:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("23:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_4_t_1
    generic_google_authentication

    @day = Date.today + 4
    @t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_4_t_2
    generic_google_authentication

    @day = Date.today + 4
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_4_t_3
    generic_google_authentication

    @day = Date.today + 4
    @t_1 = Time.parse("17:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("18:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_4_t_4
    generic_google_authentication

    @day = Date.today + 4
    @t_1 = Time.parse("18:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("20:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_4_t_5
    generic_google_authentication

    @day = Date.today + 4
    @t_1 = Time.parse("20:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("21:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_4_t_6
    generic_google_authentication

    @day = Date.today + 4
    @t_1 = Time.parse("21:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("23:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_5_t_1
    generic_google_authentication

    @day = Date.today + 5
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_5_t_2
    generic_google_authentication

    @day = Date.today + 5
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_5_t_3
    generic_google_authentication

    @day = Date.today + 5
    @t_1 = Time.parse("17:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("18:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_5_t_4
    generic_google_authentication

    @day = Date.today + 5
    @t_1 = Time.parse("18:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("20:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_5_t_5
    generic_google_authentication

    @day = Date.today + 5
    @t_1 = Time.parse("20:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("21:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_5_t_6
    generic_google_authentication

    @day = Date.today + 5
    @t_1 = Time.parse("21:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("23:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_6_t_1
    generic_google_authentication

    @day = Date.today + 6
    @t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_6_t_2
    generic_google_authentication

    @day = Date.today + 6
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_6_t_3
    generic_google_authentication

    @day = Date.today + 6
    @t_1 = Time.parse("17:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("18:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_6_t_4
    generic_google_authentication

    @day = Date.today + 6
    @t_1 = Time.parse("18:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("20:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_6_t_5
    generic_google_authentication

    @day = Date.today + 6
    @t_1 = Time.parse("20:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("21:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_6_t_6
    generic_google_authentication

    @day = Date.today + 6
    @t_1 = Time.parse("21:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("23:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_7_t_1
    generic_google_authentication

    @day = Date.today + 7
    @t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_7_t_2
    generic_google_authentication

    @day = Date.today + 7
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_7_t_3
    generic_google_authentication

    @day = Date.today + 7
    @t_1 = Time.parse("17:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("18:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_7_t_4
    generic_google_authentication

    @day = Date.today + 7
    @t_1 = Time.parse("18:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("20:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_7_t_5
    generic_google_authentication

    @day = Date.today + 7
    @t_1 = Time.parse("20:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("21:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_7_t_6
    generic_google_authentication

    @day = Date.today + 7
    @t_1 = Time.parse("21:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("23:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end
private

  def load_user
    @user = User.find(params[:user_id])
  end

  def appointment_params
    params.require(:appointment).permit(:event_start_time, :event_end_time, :event_invitation_status, :trainer_id, :trainee_id, :created_at, :updated_at)
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
    @service = Google::Apis::CalendarV3::CalendarService.new
    @service.authorization = client
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

  def time_slots
   upper_i = (@day + @t_1).to_i
   lower_i = (@day + @t_2).to_i

   upper = Time.at(upper_i)
   lower = Time.at(lower_i)

   event = Google::Apis::CalendarV3::Event.new({
     'summary':"Training Sessions with #{current_user.email}",
     # 'location':'Bitmaker',
     'description':'Testing insert event',
     'start':{
       'date_time': DateTime.parse("#{upper}")
     },
     'end':{
       'date_time': DateTime.parse("#{lower}")
     },
     'attendees':[
       {'email':"#{@user.email}"},
     ]
   })

   invitation = @service.insert_event('primary', event)
   @appointment = Appointment.create(
     event_start_time: DateTime.parse("#{upper}"),
     event_end_time: DateTime.parse("#{lower}"),
     event_invitation_status: true,
     trainee_id: "#{current_user.id}",
     trainer_id: "#{@user.id}"
   )
   flash[:notice] = "Invitation sent for #{@appointment.event_start_time} to #{@appointment.event_end_time}!"
 end
end
