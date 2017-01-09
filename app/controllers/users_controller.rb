class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :destroy, :update]

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

  def weekly_event_list
    google_authentication

    # result = service.list_events('primary')
    weekly = @result.items.map {|e|
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

private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :address, :trainer, :password, :password_confirmation)
  end

  def google_authentication
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
    @result = service.list_events('primary')
  end

  def next_six_days
    tomorrow = Date.today + 1
    @next_six_days = (tomorrow .. tomorrow + 6).map {|date| "#{date}"}
  end
end
