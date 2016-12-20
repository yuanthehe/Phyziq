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
    @weekly_event_list = weekly_event_list
  end

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
    if session[:access_token] == nil
       flash[:alert] = "Please login through Google to view calendar info!"
       redirect_to auth_at_provider_path(:provider => :google)
    else
       client = Signet::OAuth2::Client.new({
       client_id: "#{Rails.application.secrets.sorcery_google_key}",
       client_secret: "#{Rails.application.secrets.sorcery_google_secret}",
       token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
       access_token: session[:access_token]
       })
       client.expires_in = Time.now + 1_000_000
       service = Google::Apis::CalendarV3::CalendarService.new
       service.authorization = client
      #  d = Date.today
      #  date = d.strftime("%F").split("-").map(&:to_i)
      #  t = Time.now
      #  time = t.strftime("%F").split("-").map(&:to_i)
       #date && time format now equal ["YYYY","MM","DD"]
       time_slots = ["10","12","14","16","18"]
       tester = ["test"]
       result = service.list_events('primary')
         event_info = result.items.map { |e| #builds new array with return values
           if e.start.date.instance_of?(Date)
             #  e.start.date.strftime("%F").split("-").map(&:to_i).include?(date)
             next_seven_days.include?(e.start.date)
             next e.start.date
           elsif e.start.date_time.instance_of?(DateTime)
             puts "looooop"
              d = e.start.date_time.strftime("%H")
              if time_slots.include?(d)
                next tester
              else
                next time_slots
              end
           else
             flash[:alert] = 'No available times in the next seven days'
           end
         }
     end
  end

  def daily_event_list
    #Should be redirected here from weekly_event_list
    #Loop through time_slots array to check for available time_slots
    #Display time slots that do not include e.start.date_time("%H")
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

  def next_seven_days
    today = Date.today
    (today .. today + 7).inject {|init, date| "#{init} #{date}"}
  end
end
