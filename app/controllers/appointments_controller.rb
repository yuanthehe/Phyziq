class AppointmentsController < ApplicationController
  before_action :require_login
  before_action :load_user

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
  end

  def edit

  end

  def update

  end

  def destroy
    if @appointment.destroy
      google_authentication
      @client.delete_event('primary', "#{@appointment.google_event_id}")
      render "/users/#{@user.id}"
    else
      flash[:alert] = "Failed to delete event!"
    end
  end

  def d_1_t_1
    google_authentication

    @day = Date.today + 1
    @t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_1_t_2
    google_authentication

    @day = Date.today + 1
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_1_t_3
    google_authentication

    @day = Date.today + 1
    @t_1 = Time.parse("17:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("18:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_1_t_4
    google_authentication

    @day = Date.today + 1
    @t_1 = Time.parse("18:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("20:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_1_t_5
    google_authentication

    @day = Date.today + 1
    @t_1 = Time.parse("20:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("21:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_1_t_6
    google_authentication

    @day = Date.today + 1
    @t_1 = Time.parse("21:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("23:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_2_t_1
    google_authentication

    @day = Date.today + 2
    @t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_2_t_2
    google_authentication

    @day = Date.today + 2
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_2_t_3
    google_authentication

    @day = Date.today + 2
    @t_1 = Time.parse("17:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("18:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_2_t_4
    google_authentication

    @day = Date.today + 2
    @t_1 = Time.parse("18:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("20:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_2_t_5
    google_authentication

    @day = Date.today + 2
    @t_1 = Time.parse("20:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("21:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_2_t_6
    google_authentication

    @day = Date.today + 2
    @t_1 = Time.parse("21:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("23:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_3_t_1
    google_authentication

    @day = Date.today + 3
    @t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_3_t_2
    google_authentication

    @day = Date.today + 3
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_3_t_3
    google_authentication

    @day = Date.today + 3
    @t_1 = Time.parse("17:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("18:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_3_t_4
    google_authentication

    @day = Date.today + 3
    @t_1 = Time.parse("18:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("20:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_3_t_5
    google_authentication

    @day = Date.today + 3
    @t_1 = Time.parse("20:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("21:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_3_t_6
    google_authentication

    @day = Date.today + 3
    @t_1 = Time.parse("21:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("23:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_4_t_1
    google_authentication

    @day = Date.today + 4
    @t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_4_t_2
    google_authentication

    @day = Date.today + 4
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_4_t_3
    google_authentication

    @day = Date.today + 4
    @t_1 = Time.parse("17:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("18:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_4_t_4
    google_authentication

    @day = Date.today + 4
    @t_1 = Time.parse("18:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("20:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_4_t_5
    google_authentication

    @day = Date.today + 4
    @t_1 = Time.parse("20:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("21:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_4_t_6
    google_authentication

    @day = Date.today + 4
    @t_1 = Time.parse("21:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("23:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_5_t_1
    google_authentication

    @day = Date.today + 5
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_5_t_2
    google_authentication

    @day = Date.today + 5
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_5_t_3
    google_authentication

    @day = Date.today + 5
    @t_1 = Time.parse("17:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("18:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_5_t_4
    google_authentication

    @day = Date.today + 5
    @t_1 = Time.parse("18:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("20:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_5_t_5
    google_authentication

    @day = Date.today + 5
    @t_1 = Time.parse("20:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("21:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_5_t_6
    google_authentication

    @day = Date.today + 5
    @t_1 = Time.parse("21:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("23:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_6_t_1
    google_authentication

    @day = Date.today + 6
    @t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_6_t_2
    google_authentication

    @day = Date.today + 6
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_6_t_3
    google_authentication

    @day = Date.today + 6
    @t_1 = Time.parse("17:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("18:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_6_t_4
    google_authentication

    @day = Date.today + 6
    @t_1 = Time.parse("18:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("20:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_6_t_5
    google_authentication

    @day = Date.today + 6
    @t_1 = Time.parse("20:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("21:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_6_t_6
    google_authentication

    @day = Date.today + 6
    @t_1 = Time.parse("21:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("23:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_7_t_1
    google_authentication

    @day = Date.today + 7
    @t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_7_t_2
    google_authentication

    @day = Date.today + 7
    @t_1 = Time.parse("15:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("17:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_7_t_3
    google_authentication

    @day = Date.today + 7
    @t_1 = Time.parse("17:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("18:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_7_t_4
    google_authentication

    @day = Date.today + 7
    @t_1 = Time.parse("18:30").seconds_since_midnight.seconds
    @t_2 = Time.parse("20:00").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_7_t_5
    google_authentication

    @day = Date.today + 7
    @t_1 = Time.parse("20:00").seconds_since_midnight.seconds
    @t_2 = Time.parse("21:30").seconds_since_midnight.seconds
    @event_time = time_slots
  end

  def d_7_t_6
    google_authentication

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
    params.require(:appointment).permit(:event_start_time, :event_end_time, :event_invitation_status, :trainer_id, :trainee_id, :created_at, :updated_at, :google_event_id)
  end

  def google_authentication
    @client = Signet::OAuth2::Client.new({
    client_id: "#{Rails.application.secrets.sorcery_google_key}",
    client_secret: "#{Rails.application.secrets.sorcery_google_secret}",
    token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
    access_token: session[:access_token]
    })
    @client.expires_in = Time.now + 1_000_000
    @service = Google::Apis::CalendarV3::CalendarService.new
    @service.authorization = @client
  end

  def time_slots
   upper_i = (@day + @t_1).to_i
   lower_i = (@day + @t_2).to_i

   upper = Time.at(upper_i)
   lower = Time.at(lower_i)
   up = DateTime.parse("#{upper}")
   low = DateTime.parse("#{lower}")

   event = Google::Apis::CalendarV3::Event.new({
        'summary':"#{current_user.name}'s Training Session with #{@user.name}",
        'description':'Booked through Phyziq.com',
        # 'id':"12345",
        'start':{
          'date_time': "#{up}"
        },
        'end':{
          'date_time': "#{low}"
        },
        'attendees':[
          {'email':"#{@user.email}"},
        ],
        'reminders': {
          'useDefault': false
        }
      })
   @result = @service.insert_event('primary', event)

   if current_user.trainer == false
      @appointment = Appointment.create(
        summary: "#{current_user.name}'s Training Session with #{@user.name}",
        event_start_time: "#{up}",
        event_end_time: "#{low}",
        event_invitation_status: true,
        trainee_id: "#{current_user.id}",
        trainer_id: "#{@user.id}",
        google_event_id: "#{@result.id}"
      )
   else
      @appointment = Appointment.create(
        summary: "#{@user.name}'s Training Session with #{current_user.name}",
        event_start_time: "#{up}",
        event_end_time: "#{low}",
        event_invitation_status: true,
        trainee_id: "#{@user.id}",
        trainer_id: "#{current_user.id}",
        google_event_id: "#{@result.id}"
      )
   end
   flash[:notice] = "Invitation sent for #{up.strftime("%A %d/%m/%Y %T")} to #{low.strftime("%A %d/%m/%Y %T")}"
  end
end
