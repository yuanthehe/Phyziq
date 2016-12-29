class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :destroy, :update]
  # before_action :redirect, only: [:show]
  # before_action :calendar_callback, only: [:show]

  def new
    @user = User.new
  end

  def index
    @user = User.where(trainer: true)
      if params[:search]
        @user = User.search(params[:search]).order("name ASC")
      else
        @user = User.all
      end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      if @user.trainer == true
        auto_login(@user)
        flash[:alert] = "Trainer signed up!"
        redirect_to user_url(@user)
      else
        auto_login(@user)
        flash[:alert] = "Trainee signed up!"
        redirect_to users_url
      end
    else
      flash[:alert] = "Failed to signed up!"
      render 'new'
    end
  end

  def show
    # @user = User.find(params[:id])
  end

  # def freebusy
  #   client = Signet::OAuth2::Client.new({
  #   client_id: "#{Rails.application.secrets.sorcery_google_key}",
  #   client_secret: "#{Rails.application.secrets.sorcery_google_secret}",
  #   token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
  #   access_token: session[:access_token]
  #   })
  #   client.expires_in = Time.now + 1_000_000
  #   service = Google::Apis::CalendarV3::CalendarService.new

    # service = Google::Apis::CalendarV3::FreeBusyCalendar.new({
    #   calendarId: 'primary',
      # start_time: '2016-12-27T08:00:00-08:00',
      # end_time: '2016-12-27T20:00:00-08:00'
    # })

    # service.authorization = client
    # result = service.query_freebusy('primary')
  #   body = Google::Apis::CalendarV3::FreeBusyRequest.new
  #     body.items = ['primary']
  #     body.time_min = "2016-12-27T06:00:00-08:00"
  #     body.time_max = "2016-12-28T06:00:00-08:00"
  #
  #  service = Google::Apis::CalendarV3::CalendarService.new
  #  service.authorization = client
  #  result = service.query_freebusy(body).busy
  #
  # end

  def edit
  #  @user = User.find(params[:id])
  end

  def update
   @user = User.find(params[:id])
    if @user.update_attributes(user_params)
       redirect_to user_url
    else
       render :edit
    end
  end

  def destroy
  #  @user = User.find(params[:id])
    @user.destroy
    redirect_to :new
  end

  #Need to create a weekly_event_list method
  def weekly_event_list
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
      weekly = result.items.map {|e|
           e.start.date
         }.compact

      next_six_days.map {|day|
        if weekly.include?(day)
          next "Busy on #{day}"
        else
          next "Free on #{day}"
        end
        }
  end

  def day_1_t1
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

    start_hourly = result.items.map { |e|
      if e.start.date_time != nil
         e.start.date_time.to_i
      end
    }.compact

    end_hourly = result.items.map { |e|
      if e.end.date_time != nil
         e.end.date_time.to_i
      end
    }.compact

    # hourly = start_hourly.concat(end_hourly)

    day_1.map {|hour|
      if start_hourly.each {|s| s >= hour
        day_1.delete(hour)
      }
        # next "Busy at #{hour}"
      elsif end_hourly.each {|e| e <= hour
        day_1.delete(hour)
      }
        # next "Free at #{hour}"
      end
    }.compact
  end

  def calendars
    client = Signet::OAuth2::Client.new({
      client_id: "#{Rails.application.secrets.sorcery_google_key}",
      client_secret: "#{Rails.application.secrets.sorcery_google_secret}",
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      access_token: session[:access_token]
    })
    client.expires_in = Time.now + 1_000_000
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    @calendar_list = service.list_calendar_lists
  end

private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :address, :trainer, :password, :password_confirmation)
  end

  def next_six_days
    tomorrow = Date.today + 1
    (tomorrow .. tomorrow + 6).map {|date| "#{date}"}
  end

  def available_hours
    d_1 = Date.today + 1
    d_2 = Date.today + 2
    d_3 = Date.today + 3
    d_4 = Date.today + 4
    d_5 = Date.today + 5
    d_6 = Date.today + 6
    d_7 = Date.today + 7

    t_1 = Time.parse("09:00").seconds_since_midnight.seconds
    t_2 = Time.parse("10:00").seconds_since_midnight.seconds
    t_3 = Time.parse("11:00").seconds_since_midnight.seconds
    t_4 = Time.parse("12:00").seconds_since_midnight.seconds
    t_5 = Time.parse("13:00").seconds_since_midnight.seconds
    t_6 = Time.parse("14:00").seconds_since_midnight.seconds
    t_7 = Time.parse("15:00").seconds_since_midnight.seconds
    t_8 = Time.parse("16:00").seconds_since_midnight.seconds
    t_9 = Time.parse("17:00").seconds_since_midnight.seconds
    t_10 = Time.parse("18:00").seconds_since_midnight.seconds

    day_1 = [(d_1 + t_1).to_i, (d_1 + t_2).to_i, (d_1 + t_3).to_i, (d_1 + t_4).to_i, (d_1 + t_5).to_i, (d_1 + t_6).to_i ,(d_1 + t_7).to_i, (d_1 + t_8).to_i, (d_1 + t_9).to_i ,(d_1 + t_10).to_i]
    day_2 = [(d_2 + t_1).to_i, (d_2 + t_2).to_i, (d_2 + t_3).to_i, (d_2 + t_4).to_i, (d_2 + t_5).to_i, (d_2 + t_6).to_i ,(d_2 + t_7).to_i, (d_2 + t_8).to_i, (d_2 + t_9).to_i ,(d_2 + t_10).to_i]
    day_3 = [(d_3 + t_1).to_i, (d_3 + t_2).to_i, (d_3 + t_3).to_i, (d_3 + t_4).to_i, (d_3 + t_5).to_i, (d_3 + t_6).to_i ,(d_3 + t_7).to_i, (d_3 + t_8).to_i, (d_3 + t_9).to_i ,(d_3 + t_10).to_i]
    day_4 = [(d_4 + t_1).to_i, (d_4 + t_2).to_i, (d_4 + t_3).to_i, (d_4 + t_4).to_i, (d_4 + t_5).to_i, (d_4 + t_6).to_i ,(d_4 + t_7).to_i, (d_4 + t_8).to_i, (d_4 + t_9).to_i ,(d_4 + t_10).to_i]
    day_5 = [(d_5 + t_1).to_i, (d_5 + t_2).to_i, (d_5 + t_3).to_i, (d_5 + t_4).to_i, (d_5 + t_5).to_i, (d_5 + t_6).to_i ,(d_5 + t_7).to_i, (d_5 + t_8).to_i, (d_5 + t_9).to_i ,(d_5 + t_10).to_i]
    day_6 = [(d_6 + t_1).to_i, (d_6 + t_2).to_i, (d_6 + t_3).to_i, (d_6 + t_4).to_i, (d_6 + t_5).to_i, (d_6 + t_6).to_i ,(d_6 + t_7).to_i, (d_6 + t_8).to_i, (d_6 + t_9).to_i ,(d_6 + t_10).to_i]
    day_7 = [(d_7 + t_1).to_i, (d_7 + t_2).to_i, (d_7 + t_3).to_i, (d_7 + t_4).to_i, (d_7 + t_5).to_i, (d_7 + t_6).to_i ,(d_7 + t_7).to_i, (d_7 + t_8).to_i, (d_7 + t_9).to_i ,(d_7 + t_10).to_i]

    weekly_available_hours = {day_1, day_2, day_3, day_4, day_5, day_6, day_7}
  end

  def day_1
    d_1 = Date.today + 1
    t_1 = Time.parse("09:00").seconds_since_midnight.seconds
    t_2 = Time.parse("10:00").seconds_since_midnight.seconds
    t_3 = Time.parse("11:00").seconds_since_midnight.seconds
    t_4 = Time.parse("12:00").seconds_since_midnight.seconds
    t_5 = Time.parse("13:00").seconds_since_midnight.seconds
    t_6 = Time.parse("14:00").seconds_since_midnight.seconds
    t_7 = Time.parse("15:00").seconds_since_midnight.seconds
    t_8 = Time.parse("16:00").seconds_since_midnight.seconds
    t_9 = Time.parse("17:00").seconds_since_midnight.seconds
    t_10 = Time.parse("18:00").seconds_since_midnight.seconds
    day_1 = [(d_1 + t_1).to_i, (d_1 + t_2).to_i, (d_1 + t_3).to_i, (d_1 + t_4).to_i, (d_1 + t_5).to_i, (d_1 + t_6).to_i ,(d_1 + t_7).to_i, (d_1 + t_8).to_i, (d_1 + t_9).to_i ,(d_1 + t_10).to_i]
  end

  def day_2
    d_2 = Date.today + 2
    t_1 = Time.parse("09:00").seconds_since_midnight.seconds
    t_2 = Time.parse("10:00").seconds_since_midnight.seconds
    t_3 = Time.parse("11:00").seconds_since_midnight.seconds
    t_4 = Time.parse("12:00").seconds_since_midnight.seconds
    t_5 = Time.parse("13:00").seconds_since_midnight.seconds
    t_6 = Time.parse("14:00").seconds_since_midnight.seconds
    t_7 = Time.parse("15:00").seconds_since_midnight.seconds
    t_8 = Time.parse("16:00").seconds_since_midnight.seconds
    t_9 = Time.parse("17:00").seconds_since_midnight.seconds
    t_10 = Time.parse("18:00").seconds_since_midnight.seconds
    day_2 = [(d_2 + t_1).to_i, (d_2 + t_2).to_i, (d_2 + t_3).to_i, (d_2 + t_4).to_i, (d_2 + t_5).to_i, (d_2 + t_6).to_i ,(d_2 + t_7).to_i, (d_2 + t_8).to_i, (d_2 + t_9).to_i ,(d_2 + t_10).to_i]
  end

  def day_3
    d_3 = Date.today + 3
    t_1 = Time.parse("09:00").seconds_since_midnight.seconds
    t_2 = Time.parse("10:00").seconds_since_midnight.seconds
    t_3 = Time.parse("11:00").seconds_since_midnight.seconds
    t_4 = Time.parse("12:00").seconds_since_midnight.seconds
    t_5 = Time.parse("13:00").seconds_since_midnight.seconds
    t_6 = Time.parse("14:00").seconds_since_midnight.seconds
    t_7 = Time.parse("15:00").seconds_since_midnight.seconds
    t_8 = Time.parse("16:00").seconds_since_midnight.seconds
    t_9 = Time.parse("17:00").seconds_since_midnight.seconds
    t_10 = Time.parse("18:00").seconds_since_midnight.seconds
    day_3 = [(d_3 + t_1).to_i, (d_3 + t_2).to_i, (d_3 + t_3).to_i, (d_3 + t_4).to_i, (d_3 + t_5).to_i, (d_3 + t_6).to_i ,(d_3 + t_7).to_i, (d_3 + t_8).to_i, (d_3 + t_9).to_i ,(d_3 + t_10).to_i]
  end

  def day_4
    d_4 = Date.today + 4
    t_1 = Time.parse("09:00").seconds_since_midnight.seconds
    t_2 = Time.parse("10:00").seconds_since_midnight.seconds
    t_3 = Time.parse("11:00").seconds_since_midnight.seconds
    t_4 = Time.parse("12:00").seconds_since_midnight.seconds
    t_5 = Time.parse("13:00").seconds_since_midnight.seconds
    t_6 = Time.parse("14:00").seconds_since_midnight.seconds
    t_7 = Time.parse("15:00").seconds_since_midnight.seconds
    t_8 = Time.parse("16:00").seconds_since_midnight.seconds
    t_9 = Time.parse("17:00").seconds_since_midnight.seconds
    t_10 = Time.parse("18:00").seconds_since_midnight.seconds
    day_4 = [(d_4 + t_1).to_i, (d_4 + t_2).to_i, (d_4 + t_3).to_i, (d_4 + t_4).to_i, (d_4 + t_5).to_i, (d_4 + t_6).to_i ,(d_4 + t_7).to_i, (d_4 + t_8).to_i, (d_4 + t_9).to_i ,(d_4 + t_10).to_i]
  end

  def day_5
    d_5 = Date.today + 5
    t_1 = Time.parse("09:00").seconds_since_midnight.seconds
    t_2 = Time.parse("10:00").seconds_since_midnight.seconds
    t_3 = Time.parse("11:00").seconds_since_midnight.seconds
    t_4 = Time.parse("12:00").seconds_since_midnight.seconds
    t_5 = Time.parse("13:00").seconds_since_midnight.seconds
    t_6 = Time.parse("14:00").seconds_since_midnight.seconds
    t_7 = Time.parse("15:00").seconds_since_midnight.seconds
    t_8 = Time.parse("16:00").seconds_since_midnight.seconds
    t_9 = Time.parse("17:00").seconds_since_midnight.seconds
    t_10 = Time.parse("18:00").seconds_since_midnight.seconds
    day_5 = [(d_5 + t_1).to_i, (d_5 + t_2).to_i, (d_5 + t_3).to_i, (d_5 + t_4).to_i, (d_5 + t_5).to_i, (d_5 + t_6).to_i ,(d_5 + t_7).to_i, (d_5 + t_8).to_i, (d_5 + t_9).to_i ,(d_5 + t_10).to_i]
  end

  def day_6
    d_6 = Date.today + 6
    t_1 = Time.parse("09:00").seconds_since_midnight.seconds
    t_2 = Time.parse("10:00").seconds_since_midnight.seconds
    t_3 = Time.parse("11:00").seconds_since_midnight.seconds
    t_4 = Time.parse("12:00").seconds_since_midnight.seconds
    t_5 = Time.parse("13:00").seconds_since_midnight.seconds
    t_6 = Time.parse("14:00").seconds_since_midnight.seconds
    t_7 = Time.parse("15:00").seconds_since_midnight.seconds
    t_8 = Time.parse("16:00").seconds_since_midnight.seconds
    t_9 = Time.parse("17:00").seconds_since_midnight.seconds
    t_10 = Time.parse("18:00").seconds_since_midnight.seconds
    day_6 = [(d_6 + t_1).to_i, (d_6 + t_2).to_i, (d_6 + t_3).to_i, (d_6 + t_4).to_i, (d_6 + t_5).to_i, (d_6 + t_6).to_i ,(d_6 + t_7).to_i, (d_6 + t_8).to_i, (d_6 + t_9).to_i ,(d_6 + t_10).to_i]
  end

  def day_7
    d_7 = Date.today + 7
    t_1 = Time.parse("09:00").seconds_since_midnight.seconds
    t_2 = Time.parse("10:00").seconds_since_midnight.seconds
    t_3 = Time.parse("11:00").seconds_since_midnight.seconds
    t_4 = Time.parse("12:00").seconds_since_midnight.seconds
    t_5 = Time.parse("13:00").seconds_since_midnight.seconds
    t_6 = Time.parse("14:00").seconds_since_midnight.seconds
    t_7 = Time.parse("15:00").seconds_since_midnight.seconds
    t_8 = Time.parse("16:00").seconds_since_midnight.seconds
    t_9 = Time.parse("17:00").seconds_since_midnight.seconds
    t_10 = Time.parse("18:00").seconds_since_midnight.seconds
    day_7 = [(d_7 + t_1).to_i, (d_7 + t_2).to_i, (d_7 + t_3).to_i, (d_7 + t_4).to_i, (d_7 + t_5).to_i, (d_7 + t_6).to_i ,(d_7 + t_7).to_i, (d_7 + t_8).to_i, (d_7 + t_9).to_i ,(d_7 + t_10).to_i]
  end
end
