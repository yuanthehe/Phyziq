class AvailabilitiesController < ApplicationController

  def new
    @availability = Availability.new
    # day_1: @availability_day_1,
    # day_2: @availability_day_2,
    # day_3: @availability_day_3,
    # day_4: @availability_day_4,
    # day_5: @availability_day_5,
    # day_6: @availability_day_6,
    # day_7: @availability_day_7,
    # user_id: current_user.id
  end

  def create
    @availability = Availability.new(availability_params)
  end

  def weekly_hourly
    day_1
    day_2
    day_3
    day_4
    day_5
    day_6
    day_7
    @availability = Availability.create(
      day_1: @availability_day_1,
      day_2: @availability_day_2,
      day_3: @availability_day_3,
      day_4: @availability_day_4,
      day_5: @availability_day_5,
      day_6: @availability_day_6,
      day_7: @availability_day_7,
      user_id: current_user.id
      )
  end

  def edit
    @availability = Availability.find(params[:id])
  end

  def update

  end

  def day_1
    event_list_google_authentication

    @day = Date.today + 1

    @availability_day_1 = availability_check

    # @availability = Availability.create(day_1: @availability_day_1)
  end

  def day_2
    event_list_google_authentication

    @day = Date.today + 2

    @availability_day_2 = availability_check

    # @availability = Availability.create(day_2: @availability_day_2)
  end

  def day_3
    event_list_google_authentication

    @day = Date.today + 3

    @availability_day_3 = availability_check

    # @availability = Availability.create(day_3: @availability_day_3)
  end

  def day_4
    event_list_google_authentication

    @day = Date.today + 4

    @availability_day_4 = availability_check

    # @availability = Availability.create(day_4: @availability_day_4)
  end

  def day_5
    event_list_google_authentication

    @day = Date.today + 5

    @availability_day_5 = availability_check

    # @availability = Availability.create(day_5: @availability_day_5)
  end

  def day_6
    event_list_google_authentication

    @day = Date.today + 6

    @availability_day_6 = availability_check

    # @availability = Availability.create(day_6: @availability_day_6)
  end

  def day_7
    event_list_google_authentication

    @day = Date.today + 7

    @availability_day_7 = availability_check

    # @availability = Availability.create(day_7: @availability_day_7)
  end


private

  def availability_params
    params.require(:availability).permit(:day_1, :day_2, :day_3, :day_4, :day_5, :day_6, :day_7, :user_id)
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

  def availability_check
    t_1 = Time.parse("14:00").seconds_since_midnight.seconds
    t_2 = Time.parse("15:30").seconds_since_midnight.seconds
    t_3 = Time.parse("17:30").seconds_since_midnight.seconds
    t_4 = Time.parse("19:00").seconds_since_midnight.seconds
    t_5 = Time.parse("20:30").seconds_since_midnight.seconds
    t_6 = Time.parse("22:00").seconds_since_midnight.seconds

    upper_1 = (@day + t_1).to_i
    lower_1 = (@day + t_2).to_i
    upper_2 = (@day + t_2).to_i
    lower_2 = (@day + t_3).to_i
    upper_3 = (@day + t_3).to_i
    lower_3 = (@day + t_4).to_i
    upper_4 = (@day + t_4).to_i
    lower_4 = (@day + t_5).to_i
    upper_5 = (@day + t_5).to_i
    lower_5 = (@day + t_6).to_i

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

    @availability_day = []

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
      @availability_day.insert(-1, "Unavailable from 9:00am to 10:30am")
    else
      @availability_day.insert(-1, "Available from 9:00am to 10:30am")
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
        @availability_day.insert(-1, "Unavailable from 10:30am to 12:00pm")
      else
        @availability_day.insert(-1, "Available from 10:30am to 12:00pm")
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
      @availability_day.insert(-1, "Unavailable from 12:00pm to 1:30pm")
    else
      @availability_day.insert(-1, "Available from 12:00pm to 1:30pm")
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
      @availability_day.insert(-1, "Unavailable from 1:30pm to 3:00pm")
    else
      @availability_day.insert(-1, "Available from 1:30pm to 3:00pm")
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
      @availability_day.insert(-1, "Unavailable from 3:00pm to 4:30pm")
    else
      @availability_day.insert(-1, "Available from 3:00pm to 4:30pm")
    end
  end
end
