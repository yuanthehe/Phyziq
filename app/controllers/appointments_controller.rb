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

  def available_time_slot
    @available_time_slot = []
    @available_time_slot[0] = "9:00am to 10:30am"
    @available_time_slot[1] = "10:30am to 12:00pm"
    @available_time_slot[2] = "12:00pm to 1:30pm"
    @available_time_slot[3] = "1:30pm to 3:00pm"
    @available_time_slot[4] = "4:00pm to 5:30pm"
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

  def day_1
    event_list_google_authentication

    day_1 = Date.today + 1
    t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    t_3 = Time.parse("17:30").seconds_since_midnight.seconds
    t_4 = Time.parse("19:00").seconds_since_midnight.seconds
    t_5 = Time.parse("20:30").seconds_since_midnight.seconds
    t_6 = Time.parse("22:00").seconds_since_midnight.seconds

    upper_1 = (day_1 + t_1).to_i
    lower_1 = (day_1 + t_2).to_i
    upper_2 = (day_1 + t_2).to_i
    lower_2 = (day_1 + t_3).to_i
    upper_3 = (day_1 + t_3).to_i
    lower_3 = (day_1 + t_4).to_i
    upper_4 = (day_1 + t_4).to_i
    lower_4 = (day_1 + t_5).to_i
    upper_5 = (day_1 + t_5).to_i
    lower_5 = (day_1 + t_6).to_i

    i_1 = 0
    i_2 = 0
    i_3 = 0
    i_4 = 0
    i_5 = 0

    availability_1 = []
    availability_2 = []
    availability_3 = []
    availability_4 = []
    availability_5 = []

    @daily_availability_1 = []

    #Time Slot 1 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_1
           i_1 += 1
           availability_1.insert(0, "free")
        elsif @end_time[i_1] <= upper_1
          availability_1.insert(0, "free")
          i_1 += 1
        else
          i_1 += 1
          availability_1.insert(0, "busy")
        end
      end
    else
      availability_1.insert(0, "free")
    end

    if availability_1.include?("busy")
       @daily_availability_1.insert(-1, "Unavailable from 9:00am to 10:30am")
    else
       @daily_availability_1.insert(-1, "Available from 9:00am to 10:30am")
    end

    #Time Slot 2 Availablity Check
      if @start_time != nil
        @start_time.each do |time|
          if time >= lower_2
            i_2 += 1
            availability_2.insert(0, "free")
          elsif @end_time[i_2] <= upper_2
            availability_2.insert(0, "free")
            i_2 += 1
          else
            i_2 += 1
            availability_2.insert(0, "busy")
        end
      end
    else
      availability_2.insert(0, "free")
    end

    if availability_2.include?("busy")
       @daily_availability_1.insert(-1, "Unavailable from 10:30am to 12:00pm")
    else
       @daily_availability_1.insert(-1, "Available from 10:30am to 12:00pm")
    end

    #Time Slot 3 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_3
          i_3 += 1
          availability_3.insert(0, "free")
        elsif @end_time[i_3] <= upper_3
          availability_3.insert(0, "free")
          i_3 += 1
        else
          i_3 += 1
          availability_3.insert(0, "busy")
        end
      end
    else
      availability_3.insert(0, "free")
    end

    if availability_3.include?("busy")
      @daily_availability_1.insert(-1, "Unavailable from 12:00pm to 1:30pm")
    else
      @daily_availability_1.insert(-1, "Available from 12:00pm to 1:30pm")
    end

    #Time Slot 4 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_4
          i_4 += 1
          availability_4.insert(0, "free")
        elsif @end_time[i_4] <= upper_4
          availability_4.insert(0, "free")
          i_4 += 1
        else
          i_4 += 1
          availability_4.insert(0, "busy")
        end
      end
    else
      availability_4.insert(0, "free")
    end

    if availability_4.include?("busy")
        @daily_availability_1.insert(-1, "Unavailable from 1:30pm to 3:00pm")
    else
        @daily_availability_1.insert(-1, "Available from 1:30pm to 3:00pm")
    end

    #Time Slot 5 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_5
          i_5 += 1
          availability_5.insert(0, "free")
        elsif @end_time[i_5] <= upper_5
          availability_5.insert(0, "free")
          i_5 += 1
        else
          i_5 += 1
          availability_5.insert(0, "busy")
        end
      end
    else
      availability_5.insert(0, "free")
    end


      if availability_5.include?("busy")
          @daily_availability_1.insert(-1, "Unavailable from 4:00pm to 5:30pm")
      else
          @daily_availability_1.insert(-1, "Available from 4:00pm to 5:30pm")
      end


    return @daily_availability_1
  end

  def d_1_t_1
    generic_google_authentication

    day_2 = Date.today + 2
    t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    t_3 = Time.parse("17:30").seconds_since_midnight.seconds
    t_4 = Time.parse("19:00").seconds_since_midnight.seconds
    t_5 = Time.parse("20:30").seconds_since_midnight.seconds
    t_6 = Time.parse("22:00").seconds_since_midnight.seconds

    upper_1 = (day_2 + t_1).to_i
    lower_1 = (day_2 + t_2).to_i
    upper_2 = (day_2 + t_2).to_i
    lower_2 = (day_2 + t_3).to_i
    upper_3 = (day_2 + t_3).to_i
    lower_3 = (day_2 + t_4).to_i
    upper_4 = (day_2 + t_4).to_i
    lower_4 = (day_2 + t_5).to_i
    upper_5 = (day_2 + t_5).to_i
    lower_5 = (day_2 + t_6).to_i
    event = Google::Apis::CalendarV3::Event.new({
      'summary':'Testing',
      'location':'Bitmaker',
      'description':'Testing insert event',
      'start':{
        'date_time': DateTime.parse('2017-01-09T09:00:00-07:00'),
      },
      'end':{
        'date_time': DateTime.parse('2017-01-09T17:00:00-07:00'),
      }
    })

    appt = service.insert_event('primary', event)
    "Event created: #{testing.html_link}"
  end

  def day_2
    event_list_google_authentication

    day_2 = Date.today + 2
    t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    t_3 = Time.parse("17:30").seconds_since_midnight.seconds
    t_4 = Time.parse("19:00").seconds_since_midnight.seconds
    t_5 = Time.parse("20:30").seconds_since_midnight.seconds
    t_6 = Time.parse("22:00").seconds_since_midnight.seconds

    upper_1 = (day_2 + t_1).to_i
    lower_1 = (day_2 + t_2).to_i
    upper_2 = (day_2 + t_2).to_i
    lower_2 = (day_2 + t_3).to_i
    upper_3 = (day_2 + t_3).to_i
    lower_3 = (day_2 + t_4).to_i
    upper_4 = (day_2 + t_4).to_i
    lower_4 = (day_2 + t_5).to_i
    upper_5 = (day_2 + t_5).to_i
    lower_5 = (day_2 + t_6).to_i

    i_1 = 0
    i_2 = 0
    i_3 = 0
    i_4 = 0
    i_5 = 0

    availability_1 = []
    availability_2 = []
    availability_3 = []
    availability_4 = []
    availability_5 = []

    @daily_availability_2 = []

    #Time Slot 1 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_1
           i_1 += 1
           availability_1.insert(0, "free")
        elsif @end_time[i_1] <= upper_1
          availability_1.insert(0, "free")
          i_1 += 1
        else
          i_1 += 1
          availability_1.insert(0, "busy")
        end
      end
    else
      availability_1.insert(0, "free")
    end

    if availability_1.include?("busy")
       @daily_availability_2.insert(-1, "Unavailable from 9:00am to 10:30am")
    else
       @daily_availability_2.insert(-1, "Available from 9:00am to 10:30am")
    end

    #Time Slot 2 Availablity Check
      if @start_time != nil
        @start_time.each do |time|
          if time >= lower_2
            i_2 += 1
            availability_2.insert(0, "free")
          elsif @end_time[i_2] <= upper_2
            availability_2.insert(0, "free")
            i_2 += 1
          else
            i_2 += 1
            availability_2.insert(0, "busy")
        end
      end
    else
      availability_2.insert(0, "free")
    end

    if availability_2.include?("busy")
       @daily_availability_2.insert(-1, "Unavailable from 10:30am to 12:00pm")
    else
       @daily_availability_2.insert(-1, "Available from 10:30am to 12:00pm")
    end

    #Time Slot 3 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_3
          i_3 += 1
          availability_3.insert(0, "free")
        elsif @end_time[i_3] <= upper_3
          availability_3.insert(0, "free")
          i_3 += 1
        else
          i_3 += 1
          availability_3.insert(0, "busy")
        end
      end
    else
      availability_3.insert(0, "free")
    end

    if availability_3.include?("busy")
      @daily_availability_2.insert(-1, "Unavailable from 12:00pm to 1:30pm")
    else
      @daily_availability_2.insert(-1, "Available from 12:00pm to 1:30pm")
    end

    #Time Slot 4 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_4
          i_4 += 1
          availability_4.insert(0, "free")
        elsif @end_time[i_4] <= upper_4
          availability_4.insert(0, "free")
          i_4 += 1
        else
          i_4 += 1
          availability_4.insert(0, "busy")
        end
      end
    else
      availability_4.insert(0, "free")
    end

    if availability_4.include?("busy")
        @daily_availability_2.insert(-1, "Unavailable from 1:30pm to 3:00pm")
    else
        @daily_availability_2.insert(-1, "Available from 1:30pm to 3:00pm")
    end

    #Time Slot 5 Availablity Check
      if @start_time != nil
        @start_time.each do |time|
          if time >= lower_5
            i_5 += 1
            availability_5.insert(0, "free")
          elsif @end_time[i_5] <= upper_5
            availability_5.insert(0, "free")
            i_5 += 1
          else
            i_5 += 1
            availability_5.insert(0, "busy")
          end
        end
      else
        availability_5.insert(0, "free")
      end

      if availability_5.include?("busy")
          @daily_availability_2.insert(-1, "Unavailable from 4:00pm to 5:30pm")
      else
          @daily_availability_2.insert(-1, "Available from 4:00pm to 5:30pm")
      end

    return @daily_availability_2
  end

  def day_3
    event_list_google_authentication

    day_3 = Date.today + 3
    t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    t_3 = Time.parse("17:30").seconds_since_midnight.seconds
    t_4 = Time.parse("19:00").seconds_since_midnight.seconds
    t_5 = Time.parse("20:30").seconds_since_midnight.seconds
    t_6 = Time.parse("22:00").seconds_since_midnight.seconds

    upper_1 = (day_3 + t_1).to_i
    lower_1 = (day_3 + t_2).to_i
    upper_2 = (day_3 + t_2).to_i
    lower_2 = (day_3 + t_3).to_i
    upper_3 = (day_3 + t_3).to_i
    lower_3 = (day_3 + t_4).to_i
    upper_4 = (day_3 + t_4).to_i
    lower_4 = (day_3 + t_5).to_i
    upper_5 = (day_3 + t_5).to_i
    lower_5 = (day_3 + t_6).to_i

    i_1 = 0
    i_2 = 0
    i_3 = 0
    i_4 = 0
    i_5 = 0

    availability_1 = []
    availability_2 = []
    availability_3 = []
    availability_4 = []
    availability_5 = []

    @daily_availability_3 = []

    #Time Slot 1 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_1
           i_1 += 1
           availability_1.insert(0, "free")
        elsif @end_time[i_1] <= upper_1
          availability_1.insert(0, "free")
          i_1 += 1
        else
          i_1 += 1
          availability_1.insert(0, "busy")
        end
      end
    else
      availability_1.insert(0, "free")
    end

    if availability_1.include?("busy")
       @daily_availability_3.insert(-1, "Unavailable from 9:00am to 10:30am")
    else
       @daily_availability_3.insert(-1, "Available from 9:00am to 10:30am")
    end

    #Time Slot 2 Availablity Check
      if @start_time != nil
        @start_time.each do |time|
          if time >= lower_2
            i_2 += 1
            availability_2.insert(0, "free")
          elsif @end_time[i_2] <= upper_2
            availability_2.insert(0, "free")
            i_2 += 1
          else
            i_2 += 1
            availability_2.insert(0, "busy")
        end
      end
    else
      availability_2.insert(0, "free")
    end

    if availability_2.include?("busy")
       @daily_availability_3.insert(-1, "Unavailable from 10:30am to 12:00pm")
    else
       @daily_availability_3.insert(-1, "Available from 10:30am to 12:00pm")
    end

    #Time Slot 3 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_3
          i_3 += 1
          availability_3.insert(0, "free")
        elsif @end_time[i_3] <= upper_3
          availability_3.insert(0, "free")
          i_3 += 1
        else
          i_3 += 1
          availability_3.insert(0, "busy")
        end
      end
    else
      availability_3.insert(0, "free")
    end

    if availability_3.include?("busy")
      @daily_availability_3.insert(-1, "Unavailable from 12:00pm to 1:30pm")
    else
      @daily_availability_3.insert(-1, "Available from 12:00pm to 1:30pm")
    end

    #Time Slot 4 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_4
          i_4 += 1
          availability_4.insert(0, "free")
        elsif @end_time[i_4] <= upper_4
          availability_4.insert(0, "free")
          i_4 += 1
        else
          i_4 += 1
          availability_4.insert(0, "busy")
        end
      end
    else
      availability_4.insert(0, "free")
    end

    if availability_4.include?("busy")
        @daily_availability_3.insert(-1, "Unavailable from 1:30pm to 3:00pm")
    else
        @daily_availability_3.insert(-1, "Available from 1:30pm to 3:00pm")
    end

    #Time Slot 5 Availablity Check
      if @start_time != nil
        @start_time.each do |time|
          if time >= lower_5
            i_5 += 1
            availability_5.insert(0, "free")
          elsif @end_time[i_5] <= upper_5
            availability_5.insert(0, "free")
            i_5 += 1
          else
            i_5 += 1
            availability_5.insert(0, "busy")
          end
        end
      else
        availability_5.insert(0, "free")
      end

      if availability_5.include?("busy")
          @daily_availability_3.insert(-1, "Unavailable from 4:00pm to 5:30pm")
      else
          @daily_availability_3.insert(-1, "Available from 4:00pm to 5:30pm")
      end

    return @daily_availability_3
  end

  def day_4
    event_list_google_authentication

    day_4 = Date.today + 4
    t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    t_3 = Time.parse("17:30").seconds_since_midnight.seconds
    t_4 = Time.parse("19:00").seconds_since_midnight.seconds
    t_5 = Time.parse("20:30").seconds_since_midnight.seconds
    t_6 = Time.parse("22:00").seconds_since_midnight.seconds

    upper_1 = (day_4 + t_1).to_i
    lower_1 = (day_4 + t_2).to_i
    upper_2 = (day_4 + t_2).to_i
    lower_2 = (day_4 + t_3).to_i
    upper_3 = (day_4 + t_3).to_i
    lower_3 = (day_4 + t_4).to_i
    upper_4 = (day_4 + t_4).to_i
    lower_4 = (day_4 + t_5).to_i
    upper_5 = (day_4 + t_5).to_i
    lower_5 = (day_4 + t_6).to_i

    i_1 = 0
    i_2 = 0
    i_3 = 0
    i_4 = 0
    i_5 = 0

    availability_1 = []
    availability_2 = []
    availability_3 = []
    availability_4 = []
    availability_5 = []

    @daily_availability_4 = []

    #Time Slot 1 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_1
           i_1 += 1
           availability_1.insert(0, "free")
        elsif @end_time[i_1] <= upper_1
          availability_1.insert(0, "free")
          i_1 += 1
        else
          i_1 += 1
          availability_1.insert(0, "busy")
        end
      end
    else
      availability_1.insert(0, "free")
    end

    if availability_1.include?("busy")
       @daily_availability_4.insert(-1, "Unavailable from 9:00am to 10:30am")
    else
       @daily_availability_4.insert(-1, "Available from 9:00am to 10:30am")
    end

    #Time Slot 2 Availablity Check
      if @start_time != nil
        @start_time.each do |time|
          if time >= lower_2
            i_2 += 1
            availability_2.insert(0, "free")
          elsif @end_time[i_2] <= upper_2
            availability_2.insert(0, "free")
            i_2 += 1
          else
            i_2 += 1
            availability_2.insert(0, "busy")
        end
      end
    else
      availability_2.insert(0, "free")
    end

    if availability_2.include?("busy")
       @daily_availability_4.insert(-1, "Unavailable from 10:30am to 12:00pm")
    else
       @daily_availability_4.insert(-1, "Available from 10:30am to 12:00pm")
    end

    #Time Slot 3 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_3
          i_3 += 1
          availability_3.insert(0, "free")
        elsif @end_time[i_3] <= upper_3
          availability_3.insert(0, "free")
          i_3 += 1
        else
          i_3 += 1
          availability_3.insert(0, "busy")
        end
      end
    else
      availability_3.insert(0, "free")
    end

    if availability_3.include?("busy")
      @daily_availability_4.insert(-1, "Unavailable from 12:00pm to 1:30pm")
    else
      @daily_availability_4.insert(-1, "Available from 12:00pm to 1:30pm")
    end

    #Time Slot 4 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_4
          i_4 += 1
          availability_4.insert(0, "free")
        elsif @end_time[i_4] <= upper_4
          availability_4.insert(0, "free")
          i_4 += 1
        else
          i_4 += 1
          availability_4.insert(0, "busy")
        end
      end
    else
      availability_4.insert(0, "free")
    end

    if availability_4.include?("busy")
        @daily_availability_4.insert(-1, "Unavailable from 1:30pm to 3:00pm")
    else
        @daily_availability_4.insert(-1, "Available from 1:30pm to 3:00pm")
    end

    #Time Slot 5 Availablity Check
      if @start_time != nil
        @start_time.each do |time|
          if time >= lower_5
            i_5 += 1
            availability_5.insert(0, "free")
          elsif @end_time[i_5] <= upper_5
            availability_5.insert(0, "free")
            i_5 += 1
          else
            i_5 += 1
            availability_5.insert(0, "busy")
          end
        end
      else
        availability_5.insert(0, "free")
      end

      if availability_5.include?("busy")
          @daily_availability_4.insert(-1, "Unavailable from 4:00pm to 5:30pm")
      else
          @daily_availability_4.insert(-1, "Available from 4:00pm to 5:30pm")
      end

    return @daily_availability_4
  end

  def day_5
    event_list_google_authentication

    day_5 = Date.today + 5
    t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    t_3 = Time.parse("17:30").seconds_since_midnight.seconds
    t_4 = Time.parse("19:00").seconds_since_midnight.seconds
    t_5 = Time.parse("20:30").seconds_since_midnight.seconds
    t_6 = Time.parse("22:00").seconds_since_midnight.seconds

    upper_1 = (day_5 + t_1).to_i
    lower_1 = (day_5 + t_2).to_i
    upper_2 = (day_5 + t_2).to_i
    lower_2 = (day_5 + t_3).to_i
    upper_3 = (day_5 + t_3).to_i
    lower_3 = (day_5 + t_4).to_i
    upper_4 = (day_5 + t_4).to_i
    lower_4 = (day_5 + t_5).to_i
    upper_5 = (day_5 + t_5).to_i
    lower_5 = (day_5 + t_6).to_i

    i_1 = 0
    i_2 = 0
    i_3 = 0
    i_4 = 0
    i_5 = 0

    availability_1 = []
    availability_2 = []
    availability_3 = []
    availability_4 = []
    availability_5 = []

    @daily_availability_5 = []

    #Time Slot 1 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_1
           i_1 += 1
           availability_1.insert(0, "free")
        elsif @end_time[i_1] <= upper_1
          availability_1.insert(0, "free")
          i_1 += 1
        else
          i_1 += 1
          availability_1.insert(0, "busy")
        end
      end
    else
      availability_1.insert(0, "free")
    end

    if availability_1.include?("busy")
       @daily_availability_5.insert(-1, "Unavailable from 9:00am to 10:30am")
    else
       @daily_availability_5.insert(-1, "Available from 9:00am to 10:30am")
    end

    #Time Slot 2 Availablity Check
      if @start_time != nil
        @start_time.each do |time|
          if time >= lower_2
            i_2 += 1
            availability_2.insert(0, "free")
          elsif @end_time[i_2] <= upper_2
            availability_2.insert(0, "free")
            i_2 += 1
          else
            i_2 += 1
            availability_2.insert(0, "busy")
        end
      end
    else
      availability_2.insert(0, "free")
    end

    if availability_2.include?("busy")
       @daily_availability_5.insert(-1, "Unavailable from 10:30am to 12:00pm")
    else
       @daily_availability_5.insert(-1, "Available from 10:30am to 12:00pm")
    end

    #Time Slot 3 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_3
          i_3 += 1
          availability_3.insert(0, "free")
        elsif @end_time[i_3] <= upper_3
          availability_3.insert(0, "free")
          i_3 += 1
        else
          i_3 += 1
          availability_3.insert(0, "busy")
        end
      end
    else
      availability_3.insert(0, "free")
    end

    if availability_3.include?("busy")
      @daily_availability_5.insert(-1, "Unavailable from 12:00pm to 1:30pm")
    else
      @daily_availability_5.insert(-1, "Available from 12:00pm to 1:30pm")
    end

    #Time Slot 4 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_4
          i_4 += 1
          availability_4.insert(0, "free")
        elsif @end_time[i_4] <= upper_4
          availability_4.insert(0, "free")
          i_4 += 1
        else
          i_4 += 1
          availability_4.insert(0, "busy")
        end
      end
    else
      availability_4.insert(0, "free")
    end

    if availability_4.include?("busy")
        @daily_availability_5.insert(-1, "Unavailable from 1:30pm to 3:00pm")
    else
        @daily_availability_5.insert(-1, "Available from 1:30pm to 3:00pm")
    end

    #Time Slot 5 Availablity Check
      if @start_time != nil
        @start_time.each do |time|
          if time >= lower_5
            i_5 += 1
            availability_5.insert(0, "free")
          elsif @end_time[i_5] <= upper_5
            availability_5.insert(0, "free")
            i_5 += 1
          else
            i_5 += 1
            availability_5.insert(0, "busy")
          end
        end
      else
        availability_5.insert(0, "free")
      end

      if availability_5.include?("busy")
          @daily_availability_5.insert(-1, "Unavailable from 4:00pm to 5:30pm")
      else
          @daily_availability_5.insert(-1, "Available from 4:00pm to 5:30pm")
      end

    return @daily_availability_5
  end

  def day_6
    event_list_google_authentication

    day_6 = Date.today + 6
    t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    t_3 = Time.parse("17:30").seconds_since_midnight.seconds
    t_4 = Time.parse("19:00").seconds_since_midnight.seconds
    t_5 = Time.parse("20:30").seconds_since_midnight.seconds
    t_6 = Time.parse("22:00").seconds_since_midnight.seconds

    upper_1 = (day_6 + t_1).to_i
    lower_1 = (day_6 + t_2).to_i
    upper_2 = (day_6 + t_2).to_i
    lower_2 = (day_6 + t_3).to_i
    upper_3 = (day_6 + t_3).to_i
    lower_3 = (day_6 + t_4).to_i
    upper_4 = (day_6 + t_4).to_i
    lower_4 = (day_6 + t_5).to_i
    upper_5 = (day_6 + t_5).to_i
    lower_5 = (day_6 + t_6).to_i

    i_1 = 0
    i_2 = 0
    i_3 = 0
    i_4 = 0
    i_5 = 0

    availability_1 = []
    availability_2 = []
    availability_3 = []
    availability_4 = []
    availability_5 = []

    @daily_availability_6 = []

    #Time Slot 1 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_1
           i_1 += 1
           availability_1.insert(0, "free")
        elsif @end_time[i_1] <= upper_1
          availability_1.insert(0, "free")
          i_1 += 1
        else
          i_1 += 1
          availability_1.insert(0, "busy")
        end
      end
    else
      availability_1.insert(0, "free")
    end

    if availability_1.include?("busy")
       @daily_availability_6.insert(-1, "Unavailable from 9:00am to 10:30am")
    else
       @daily_availability_6.insert(-1, "Available from 9:00am to 10:30am")
    end

    #Time Slot 2 Availablity Check
      if @start_time != nil
        @start_time.each do |time|
          if time >= lower_2
            i_2 += 1
            availability_2.insert(0, "free")
          elsif @end_time[i_2] <= upper_2
            availability_2.insert(0, "free")
            i_2 += 1
          else
            i_2 += 1
            availability_2.insert(0, "busy")
        end
      end
    else
      availability_2.insert(0, "free")
    end

    if availability_2.include?("busy")
       @daily_availability_6.insert(-1, "Unavailable from 10:30am to 12:00pm")
    else
       @daily_availability_6.insert(-1, "Available from 10:30am to 12:00pm")
    end

    #Time Slot 3 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_3
          i_3 += 1
          availability_3.insert(0, "free")
        elsif @end_time[i_3] <= upper_3
          availability_3.insert(0, "free")
          i_3 += 1
        else
          i_3 += 1
          availability_3.insert(0, "busy")
        end
      end
    else
      availability_3.insert(0, "free")
    end

    if availability_3.include?("busy")
      @daily_availability_6.insert(-1, "Unavailable from 12:00pm to 1:30pm")
    else
      @daily_availability_6.insert(-1, "Available from 12:00pm to 1:30pm")
    end

    #Time Slot 4 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_4
          i_4 += 1
          availability_4.insert(0, "free")
        elsif @end_time[i_4] <= upper_4
          availability_4.insert(0, "free")
          i_4 += 1
        else
          i_4 += 1
          availability_4.insert(0, "busy")
        end
      end
    else
      availability_4.insert(0, "free")
    end

    if availability_4.include?("busy")
        @daily_availability_6.insert(-1, "Unavailable from 1:30pm to 3:00pm")
    else
        @daily_availability_6.insert(-1, "Available from 1:30pm to 3:00pm")
    end

    #Time Slot 5 Availablity Check
      if @start_time != nil
        @start_time.each do |time|
          if time >= lower_5
            i_5 += 1
            availability_5.insert(0, "free")
          elsif @end_time[i_5] <= upper_5
            availability_5.insert(0, "free")
            i_5 += 1
          else
            i_5 += 1
            availability_5.insert(0, "busy")
          end
        end
      else
        availability_5.insert(0, "free")
      end

      if availability_5.include?("busy")
          @daily_availability_6.insert(-1, "Unavailable from 4:00pm to 5:30pm")
      else
          @daily_availability_6.insert(-1, "Available from 4:00pm to 5:30pm")
      end

    return @daily_availability_6
  end

  def day_7
    event_list_google_authentication

    day_7 = Date.today + 7
    t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    t_3 = Time.parse("17:30").seconds_since_midnight.seconds
    t_4 = Time.parse("19:00").seconds_since_midnight.seconds
    t_5 = Time.parse("20:30").seconds_since_midnight.seconds
    t_6 = Time.parse("22:00").seconds_since_midnight.seconds

    upper_1 = (day_7 + t_1).to_i
    lower_1 = (day_7 + t_2).to_i
    upper_2 = (day_7 + t_2).to_i
    lower_2 = (day_7 + t_3).to_i
    upper_3 = (day_7 + t_3).to_i
    lower_3 = (day_7 + t_4).to_i
    upper_4 = (day_7 + t_4).to_i
    lower_4 = (day_7 + t_5).to_i
    upper_5 = (day_7 + t_5).to_i
    lower_5 = (day_7 + t_6).to_i

    i_1 = 0
    i_2 = 0
    i_3 = 0
    i_4 = 0
    i_5 = 0

    availability_1 = []
    availability_2 = []
    availability_3 = []
    availability_4 = []
    availability_5 = []

    @daily_availability_7 = []

    #Time Slot 1 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_1
           i_1 += 1
           availability_1.insert(0, "free")
        elsif @end_time[i_1] <= upper_1
          availability_1.insert(0, "free")
          i_1 += 1
        else
          i_1 += 1
          availability_1.insert(0, "busy")
        end
      end
    else
      availability_1.insert(0, "free")
    end

    if availability_1.include?("busy")
       @daily_availability_7.insert(-1, "Unavailable from 9:00am to 10:30am")
    else
       @daily_availability_7.insert(-1, "Available from 9:00am to 10:30am")
    end

    #Time Slot 2 Availablity Check
      if @start_time != nil
        @start_time.each do |time|
          if time >= lower_2
            i_2 += 1
            availability_2.insert(0, "free")
          elsif @end_time[i_2] <= upper_2
            availability_2.insert(0, "free")
            i_2 += 1
          else
            i_2 += 1
            availability_2.insert(0, "busy")
        end
      end
    else
      availability_2.insert(0, "free")
    end

    if availability_2.include?("busy")
       @daily_availability_7.insert(-1, "Unavailable from 10:30am to 12:00pm")
    else
       @daily_availability_7.insert(-1, "Available from 10:30am to 12:00pm")
    end

    #Time Slot 3 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_3
          i_3 += 1
          availability_3.insert(0, "free")
        elsif @end_time[i_3] <= upper_3
          availability_3.insert(0, "free")
          i_3 += 1
        else
          i_3 += 1
          availability_3.insert(0, "busy")
        end
      end
    else
      availability_3.insert(0, "free")
    end

    if availability_3.include?("busy")
      @daily_availability_7.insert(-1, "Unavailable from 12:00pm to 1:30pm")
    else
      @daily_availability_7.insert(-1, "Available from 12:00pm to 1:30pm")
    end

    #Time Slot 4 Availablity Check
    if @start_time != nil
      @start_time.each do |time|
        if time >= lower_4
          i_4 += 1
          availability_4.insert(0, "free")
        elsif @end_time[i_4] <= upper_4
          availability_4.insert(0, "free")
          i_4 += 1
        else
          i_4 += 1
          availability_4.insert(0, "busy")
        end
      end
    else
      availability_4.insert(0, "free")
    end

    if availability_4.include?("busy")
        @daily_availability_7.insert(-1, "Unavailable from 1:30pm to 3:00pm")
    else
        @daily_availability_7.insert(-1, "Available from 1:30pm to 3:00pm")
    end

    #Time Slot 5 Availablity Check
      if @start_time != nil
        @start_time.each do |time|
          if time >= lower_5
            i_5 += 1
            availability_5.insert(0, "free")
          elsif @end_time[i_5] <= upper_5
            availability_5.insert(0, "free")
            i_5 += 1
          else
            i_5 += 1
            availability_5.insert(0, "busy")
          end
        end
      else
        availability_5.insert(0, "free")
      end

      if availability_5.include?("busy")
          @daily_availability_7.insert(-1, "Unavailable from 4:00pm to 5:30pm")
      else
          @daily_availability_7.insert(-1, "Available from 4:00pm to 5:30pm")
      end

    return @daily_availability_7
  end
end
